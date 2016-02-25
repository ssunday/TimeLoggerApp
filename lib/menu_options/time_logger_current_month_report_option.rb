require "time_logger_menu_option"
require "time_logger_hour_reporting"

class TimeLoggerCurrentMonthReportOption < TimeLoggerMenuOption

  include TimeLoggerHourReporting
  include TimeLoggerTimecodes

  def initialize
    @option_description = "Current Month Report"
  end

  def execute(data_logging, io, username)
    project_hours = collect_hours_worked_by_specification(AVAILABLE_TIMECODES, data_logging.time_codes_and_hours_for_current_month)
    client_hours = collect_hours_worked_by_specification(data_logging.get_client_names, data_logging.client_names_and_hours_for_current_month)
    employee_hours = collect_hours_worked_by_specification(data_logging.get_employee_names, data_logging.employee_names_and_hours_for_current_month)
    io.display_hours_worked_per_project(AVAILABLE_TIMECODES, project_hours)
    io.display_hours_worked_per_client(data_logging.get_client_names, client_hours)
    io.display_hours_worked_by_employee(data_logging.get_employee_names, employee_hours)
  end

end
