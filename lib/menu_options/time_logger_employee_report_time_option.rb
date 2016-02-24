require "time_logger_menu_option"
require "time_logger_hour_reporting"
require "time_logger_timecodes"

class TimeLoggerEmployeeReportTimeOption < TimeLoggerMenuOption

  include TimeLoggerHourReporting
  include TimeLoggerTimecodes

  def initialize
    @option_description = "Your Current Month Report"
  end

  def execute(data_logging, io, username)
    date_list = data_logging.get_list_of_dates_worked_in_month_by_user(username)
    project_hours = collect_hours_worked_by_specification(AVAILABLE_TIMECODES,
                        data_logging.time_codes_and_hours_for_current_month_and_username(username))
    client_hours = collect_hours_worked_by_specification(data_logging.client_names,
                                        data_logging.client_names_and_hours_for_current_month_and_username(username))
    hours_worked_in_month = collect_hours_worked_by_specification(date_list,
                                      data_logging.dates_and_hours_for_current_month_and_username(username))
    io.display_hours_worked_per_project(AVAILABLE_TIMECODES, project_hours)
    io.display_hours_worked_per_client(data_logging.client_names, client_hours)
    io.display_hours_worked_in_month(date_list, hours_worked_in_month)
  end

end
