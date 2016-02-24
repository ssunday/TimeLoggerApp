require "menu_options/time_logger_log_hours_menu_option"
require "menu_options/time_logger_add_client_option"
require "menu_options/time_logger_add_employee_option"
require "menu_options/time_logger_current_month_report_option"
require "menu_options/time_logger_employee_report_time_option"
require "menu_options/time_logger_log_out_option"
require "menu_options/time_logger_menu_option"

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

  def initialize(logger, io)
    @data_logger = logger
    @io = io
  end

  def assign_menu_based_on_whether_employee_is_admin(is_user_admin)
    @active_menu = is_user_admin ? MENU_OPTIONS_ADMIN : MENU_OPTIONS_EMPLOYEE
  end

  def do_menu_option(option, username)
    if @active_menu[option] == nil
      @io.invalid_option_message
    else
      @active_menu[option].execute(@data_logger, @io, username)
    end
  end

  def options
    @active_menu.values.map {|option| option.to_s}
  end

end
