require_relative "time_logger_input_output.rb"
require_relative "time_logger_app_functions.rb"
require_relative "time_logger_admin.rb"
require_relative "time_logger_data_logging.rb"

class TimeLoggerApp

  include TimeLoggerAppFunctions

  def initialize(input_output, filenames = {})
    @io = input_output
    @admin = TimeLoggerAdmin.new(filenames[:employees_file_name], filenames[:clients_file_name])
    @employee_data_logging = TimeLoggerDataLogging.new(time_log_file_name: filenames[:time_log_file_name],
                                                        clients_file_name: filenames[:clients_file_name],
                                                        employees_file_name: filenames[:employees_file_name])
  end

  def run
    @io.welcome_message
    get_username
    @is_admin = @admin.admin_from_username?(@username)
    if @is_admin
      menu = MENU_ADMIN
    else
      menu = MENU_EMPLOYEE
    end
    @in_use = true
    while @in_use
      @io.display_menu(menu)
      option = @io.select_option(menu.length - 1)
      do_menu_option(menu.length, option)
    end
    @io.end_message
  end

  def do_menu_option(menu_length, option)
    if option == menu_length
      @in_use = false
    elsif option == 1
      employee_log_time
    elsif option == 2
      employee_report_time
    elsif option == 3 && @is_admin
      admin_report_time
    elsif option == 4 && @is_admin
      admin_add_employee
    elsif option == 5 && @is_admin
      admin_add_client
    else
      @io.bad_option
    end
  end

  def employee_log_time
    date = @io.specify_date
    hours = @io.hours_worked
    timecode_selection = @io.select_timecode(AVAILABLE_TIMECODES) - 1
    timecode = get_timecode(timecode_selection)
    client = billable_work?(timecode) ? @admin.client_names[@io.select_client(@admin.client_names) - 1] : nil
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
        date = row[1].split('/')
        month = date[1].to_i
        year = date[2].to_i
        hours = row[2].to_i
        employee_name = row[0]
        client = row[4]
        timecode = row[3]
        time_worked_by_specification(hours: row[2].to_i , specific_attribute: row[1], \
                          all_attributes: date_list, hours_collection: hours_worked_in_month)
        collect_hours_in_month(hours_collection: client_hours, all_attributes: client_names, specific_attribute: client, \
                                month: month, year: year, hours: hours)
        collect_hours_in_month(hours_collection: project_hours, all_attributes: AVAILABLE_TIMECODES, specific_attribute: timecode, \
                                month: month, year: year, hours: hours)
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
    get_admin_time_to_report(time_log: time_log, project_hours: project_hours,
                      client_hours: client_hours, employee_hours: employee_hours,
                      client_names: client_names, employee_names: employee_names)
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

  def get_username
    @username = @io.input_username
    while @admin.authorize_user(@username) == false
      @io.bad_user_name
      @username = @io.input_username
    end
  end

end
