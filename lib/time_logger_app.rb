require_relative "time_logger_input_output.rb"
require_relative "time_logger_app_functions.rb"
require_relative "time_logger_admin.rb"
require_relative "time_logger_data_logging.rb"

include TimeLoggerAppFunctions

class TimeLoggerApp

  AVAILABLE_TIMECODES = ["Billable Work", "Non-billable work", "PTO"]

  MENU_EMPLOYEE = ["Enter Hours", "Report Current Month's Time", "Log out"]

  MENU_ADMIN = ["Enter Hours", "Report Current Month's Time", "All Employee's Report",\
              "Add Employee" , "Add Client", "Log out"]

  def initialize(input_output, filenames = {})
    @io = input_output
    @admin = TimeLoggerAdmin.new(filenames[:employees_file_name], filenames[:clients_file_name])
    @employee_data_logging = TimeLoggerDataLogging.new(filenames[:time_log_file_name])
  end

  def run
    @io.welcome_message
    get_username
    is_admin = @admin.is_admin_from_user_name(@username)
    if is_admin
      menu = MENU_ADMIN
    else
      menu = MENU_EMPLOYEE
    end
    @in_use = true
    while @in_use
      @io.display_menu(menu)
      option = @io.select_option(menu.length - 1)
      do_menu_option(menu, option)
    end
    @io.end_message
  end
  
  def do_menu_option(menu, option)
    case option
    when (menu.length)
      @in_use = false
    when 1
      employee_log_time
    when 2
      employee_report_time
    when 3
      admin_report_time
    when 4
      admin_add_employee
    when 5
      admin_add_client
    end
  end

  def get_username
    @username = @io.input_username
    while authorize_user(@username, @admin.employee_names) == false
      @io.bad_user_name
      @username = @io.input_username
    end
  end

  def employee_log_time
    date = @io.specify_date
    hours = @io.hours_worked
    timecode = AVAILABLE_TIMECODES[@io.select_timecode(AVAILABLE_TIMECODES)-1]
    if timecode.eql?("Billable Work")
      client = @admin.client_names[@io.select_client(@admin.client_names) - 1]
    else
      client = nil
    end
    @employee_data_logging.log_time(username: @username, date: date, hours: hours, timecode: timecode, client: client)
  end

  def employee_report_time
    time_log = @employee_data_logging.read_data
    client_names = @admin.client_names
    project_hours = Array.new(AVAILABLE_TIMECODES.length, 0)
    client_hours = Array.new(client_names.length, 0)
    date_list = get_list_of_dates_worked_in_month(time_log, @username)
    hours_worked_in_month = Array.new(date_list.length, 0)
    time_log.each do |row|
      if row[0].eql?(@username)
        time_worked_by_specification(hours: row[2].to_i , specific_attribute: row[1], \
                          all_attributes: date_list, hours_collection: hours_worked_in_month)
        date = row[1].split('/')
        collect_project_and_client_total_hours(month: date[1].to_i, year: date[2].to_i, hours: row[2].to_i, client_names: client_names, \
                                                timecode: row[3], timecodes: AVAILABLE_TIMECODES, client: row[4], client_hours: client_hours, project_hours: project_hours)
      end
    end
    @io.display_hours_worked_per_project(AVAILABLE_TIMECODES, project_hours)
    @io.display_hours_worked_per_client(@admin.client_names, client_hours)
    @io.display_hours_worked_in_month(date_list, hours_worked_in_month)
  end

  def admin_report_time
    time_log = @employee_data_logging.read_data
    client_names = @admin.client_names
    employee_names = @admin.employee_names
    project_hours = Array.new(AVAILABLE_TIMECODES.length, 0)
    client_hours = Array.new(client_names.length,0)
    employee_hours = Array.new(employee_names.length,0)
    time_log.each do |row|
      date = row[1].split('/')
      collect_employee_total_hours(employee_hours: employee_hours, employee_names: employee_names, employee_name: row[0], \
                              month: date[1].to_i, year: date[2].to_i, hours: row[2].to_i,)
      collect_project_and_client_total_hours(month: date[1].to_i, year: date[2].to_i, hours: row[2].to_i, client_names: client_names,\
                                              timecode: row[3], timecodes: AVAILABLE_TIMECODES, client: row[4], client_hours: client_hours, project_hours: project_hours)
    end
    @io.display_hours_worked_by_employee(employee_names, employee_hours)
    @io.display_hours_worked_per_project(AVAILABLE_TIMECODES, project_hours)
    @io.display_hours_worked_per_client(client_names, client_hours)
  end

  def admin_add_employee
    employee_data = @io.get_employee_info
    @admin.add_employee(employee_data)
  end

  def admin_add_client
    client_name = @io.get_client_name
    @admin.add_client(client_name)
  end

end
