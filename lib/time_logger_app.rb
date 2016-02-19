require_relative "time_logger_app_functions.rb"
require_relative "time_logger_admin.rb"
require_relative "time_logger_data_logging.rb"

class TimeLoggerApp

  include TimeLoggerAppFunctions

  def initialize(input_output, filenames = {})
    @io = input_output
    @admin = TimeLoggerAdmin.new
    @data_logging = TimeLoggerDataLogging.new(time_log_file_name: filenames[:time_log_file_name],
                                                        clients_file_name: filenames[:clients_file_name],
                                                        employees_file_name: filenames[:employees_file_name])
    @in_use = true
  end

  def run
    @io.welcome_message
    get_username
    assign_whether_admin_or_not
    menu = assign_menu(@is_admin)
    while @in_use
      @io.display_menu(menu)
      option = @io.select_option
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
    date_and_time = @io.specify_date_and_time
    hours = @io.hours_worked
    timecode_selection = @io.select_timecode(AVAILABLE_TIMECODES) - 1
    timecode = get_timecode(timecode_selection)
    client = billable_work?(timecode) ? @data_logging.client_names[@io.select_client(@data_logging.client_names) - 1] : nil
    @data_logging.log_time([@username, date_and_time, hours, timecode, client])
  end

  def employee_report_time
    time_log = @data_logging.read_time_log_data
    client_names = @data_logging.client_names
    project_hours = Array.new(AVAILABLE_TIMECODES.length, 0)
    client_hours = Array.new(client_names.length, 0)
    date_list = get_list_of_dates_worked_in_month(time_log, @username)
    hours_worked_in_month = Array.new(date_list.length, 0)
    get_employee_time_to_report(time_log: time_log, username: @username, project_hours: project_hours,
                      client_hours: client_hours, hours_worked_in_month: hours_worked_in_month,
                      client_names: client_names, date_list: date_list)
    @io.display_project_and_client_hours(AVAILABLE_TIMECODES, client_names, project_hours, client_hours)
    @io.display_hours_worked_in_month(date_list, hours_worked_in_month)
  end

  def admin_report_time
    time_log = @data_logging.read_time_log_data
    client_names = @data_logging.client_names
    employee_names = @data_logging.employee_names
    project_hours = Array.new(AVAILABLE_TIMECODES.length, 0)
    client_hours = Array.new(client_names.length,0)
    employee_hours = Array.new(employee_names.length,0)
    get_admin_time_to_report(time_log: time_log, project_hours: project_hours,
                      client_hours: client_hours, employee_hours: employee_hours,
                      client_names: client_names, employee_names: employee_names)
    @io.display_project_and_client_hours(AVAILABLE_TIMECODES, client_names, project_hours, client_hours)
    @io.display_hours_worked_by_employee(employee_names, employee_hours)
  end

  def admin_add_employee
    employee_data = @io.get_employee_info(@data_logging.employee_names)
    @data_logging.add_employee(employee_data)
  end

  def admin_add_client
    client_name = @io.get_client_name(@data_logging.client_names)
    @data_logging.add_client([client_name])
  end

  def get_username
    @username = @io.input_username
    while @admin.authorize_user(@username, @data_logging.employee_names) == false
      @io.bad_user_name
      @username = @io.input_username
    end
  end

  private

  def assign_whether_admin_or_not
    @is_admin = @admin.admin_from_authorized_username?(@username, @data_logging.employee_data)
  end

end
