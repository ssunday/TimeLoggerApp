
require "menu_options/time_logger_log_hours_menu_option"
require "menu_options/time_logger_add_client_option"
require "menu_options/time_logger_add_employee_option"
require "menu_options/time_logger_current_month_report_option"
require "menu_options/time_logger_employee_report_time_option"
require "menu_options/time_logger_log_out_option"

class TimeLoggerMenu

  MENU_OPTIONS_EMPLOYEE = {1 => TimeLoggerLogHoursMenuOption.new,
                  2 => TimeLoggerEmployeeReportTimeOption.new,
                  3 => TimeLoggerLogoutOption.new}


  MENU_OPTIONS_ADMIN = {1 => TimeLoggerLogHoursMenuOption.new,
                  2 => TimeLoggerEmployeeReportTimeOption.new,
                  3 => TimeLoggerCurrentMonthReportOption.new,
                  4 => TimeLoggerAddEmployeeOption.new ,
                  5 => TimeLoggerAddClientOption.new,
                  6 => TimeLoggerLogoutOption.new}

  AVAILABLE_TIMECODES = ["Billable Work",
                        "Non-billable work",
                        "PTO"]

  def initialize(logger, io, is_user_admin, username)
    @data_logger = logger
    @io = io
    @active_menu = is_user_admin ? MENU_OPTIONS_ADMIN : MENU_OPTIONS_EMPLOYEE
    @username = username
  end

  def do_menu_option(option)
    @active_menu[option].execute(@data_logger, @io, @username, AVAILABLE_TIMECODES)
  end

  def options
    @active_menu.values.map {|option| option.to_s}
  end

end
