require_relative "time_logger_input_output.rb"
require_relative "time_logger_app_functions.rb"
require_relative "time_logger_admin.rb"
require_relative "time_logger_data_logging.rb"

include TimeLoggerInputOutput
include TimeLoggerAppFunctions

class TimeLoggerApp

  AVAILABLE_TIMECODES = ["Billable Work", "Non-billable work", "PTO"]

  MENU_EMPLOYEE = ["Enter Hours", "Report Current Month's Time", "Log out"]

  MENU_ADMIN = ["Enter Hours", "Report Current Month's Time", "All Employee's Report",\
              "Add Employee" , "Add Client", "Log out"]

  def initialize
    @admin = TimeLoggerAdmin.new
    @employee_data_logging = TimeLoggerDataLogging.new
  end

  def run
    welcome_message
    get_username
    is_admin = @admin.is_admin_from_user_name(@username)
    if is_admin
      menu = MENU_ADMIN
    else
      menu = MENU_EMPLOYEE
    end
    @in_use = true
    while @in_use
      display_menu(menu)
      option = select_option(menu.length - 1)
      do_menu_option(menu, option)
    end
    end_message
  end

  private

  def do_menu_option(menu, option)
    case option
    when (menu.length)
      @in_use = false
    when 1
      date = specify_date
      hours = hours_worked
      timecode = AVAILABLE_TIMECODES[select_timecode(AVAILABLE_TIMECODES)-1]
      if timecode.eql?("Billable Work")
        client = @admin.client_names[select_client(@admin.client_names) - 1]
      else
        client = nil
      end
      @employee_data_logging.log_time(username: @username, date: date, hours: hours, timecode: timecode, client: client)
    when 2
      time_log = @employee_data_logging.read_data
      client_names = @admin.client_names
      project_hours = Array.new(AVAILABLE_TIMECODES.length, 0)
      client_hours = Array.new(client_names.length,0)
      time_log.each do |row|
        if row[0].eql?(@username)
          date = row[1].split('/')
          if date[1].to_i == Date.today.month && date[2].to_i == Date.today.year
            for i in 0..AVAILABLE_TIMECODES.length
              if row[3].eql?(AVAILABLE_TIMECODES[i])
                project_hours[i] += row[2].to_i
              end
            end
            for j in 0..client_names.length
              if row[4].eql?(client_names[j])
                client_hours[j] += row[2].to_i
              end
            end
          end
        end
      end
      display_hours_worked_per_project(AVAILABLE_TIMECODES, project_hours)
      display_hours_worked_per_client(client_names, client_hours)
    when 4
      employee_data = get_employee_info
      @admin.add_employee(employee_data)
    when 5
      client_name = get_client_name
      @admin.add_client(client_name)
    end

  end


  def get_username
    @username = input_username
    while authorize_user(@username, @admin.employee_names) == false
      bad_user_name
      @username = input_username
    end
  end

end
