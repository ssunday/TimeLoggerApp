$LOAD_PATH.unshift(File.dirname(__FILE__))

require "time_logger_admin"
require "time_logger_app_menu_functions"

class TimeLoggerApp

  include TimeLoggerAppMenuFunctions

  def initialize(input_output, data_logging)
    @io = input_output
    @admin = TimeLoggerAdmin.new
    @data_logging = data_logging
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
    timecode = @io.select_timecode(AVAILABLE_TIMECODES)
    client = billable_work?(timecode) ? @io.select_client(@data_logging.client_names) : nil
    @data_logging.log_time([@username, date_and_time, hours, timecode, client])
  end

  def employee_report_time
    date_list = @data_logging.get_list_of_dates_worked_in_month_by_user(@username)
    project_hours = collect_hours_worked_by_specification(AVAILABLE_TIMECODES,
                        @data_logging.time_codes_and_hours_for_current_month_and_username(@username))
    client_hours = collect_hours_worked_by_specification(@data_logging.client_names,
                                        @data_logging.client_names_and_hours_for_current_month_and_username(@username))
    hours_worked_in_month = collect_hours_worked_by_specification(date_list,
                                      @data_logging.dates_and_hours_for_current_month_and_username(@username))
    @io.display_hours_worked_per_project(AVAILABLE_TIMECODES, project_hours)
    @io.display_hours_worked_per_client(@data_logging.client_names, client_hours)
    @io.display_hours_worked_in_month(date_list, hours_worked_in_month)
  end

  def admin_report_time
    project_hours = collect_hours_worked_by_specification(AVAILABLE_TIMECODES, @data_logging.time_codes_and_hours_for_current_month)
    client_hours = collect_hours_worked_by_specification(@data_logging.client_names, @data_logging.client_names_and_hours_for_current_month)
    employee_hours = collect_hours_worked_by_specification(@data_logging.employee_names, @data_logging.employee_names_and_hours_for_current_month)
    @io.display_hours_worked_per_project(AVAILABLE_TIMECODES, project_hours)
    @io.display_hours_worked_per_client(@data_logging.client_names, client_hours)
    @io.display_hours_worked_by_employee(@data_logging.employee_names, employee_hours)
  end

  def admin_add_employee
    employee_data = @io.get_employee_info(@data_logging.employee_names)
    @data_logging.add_employee(employee_data)
  end

  def admin_add_client
    client_name = @io.get_client_name(@data_logging.client_names)
    @data_logging.add_client(client_name)
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
