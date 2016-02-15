require_relative "time_logger_input_output.rb"
require_relative "time_logger_app_functions.rb"
require_relative "time_logger_admin.rb"
require_relative "time_logger_data_logging.rb"

include TimeLoggerInputOutput
include TimeLoggerAppFunctions

class TimeLoggerApp

  MENU_EMPLOYEE = ["Enter Hours", "Report Current Month's Time", "Log out"]

  MENU_ADMIN = ["Enter Hours", "Report Current Month's Time", \
              "Add Employee" , "Add Client", "Log out"]

  def initialize
    @admin = TimeLoggerAdmin.new
    @employee_data_logging = TimeLoggerDataLogging.new
  end

  def run
    welcome_message
    username = get_username
    is_admin = @admin.is_admin_from_user_name(username)
    @in_use = true
    while @in_use
      if is_admin
        display_menu(MENU_ADMIN)
        option = select_option(MENU_ADMIN.length - 1)
        do_menu_option_admin(option)
      else
        display_menu(MENU_EMPLOYEE)
        option = select_option(MENU_EMPLOYEE.length - 1)
        do_menu_option_employee(option)
      end
    end
    end_message
  end

  private

  def do_menu_option_employee(option)
    case option
    when (MENU_EMPLOYEE.length)
      @in_use = false
    end
  end

  def do_menu_option_admin(option)
    case option
    when (MENU_ADMIN.length)
      @in_use = false
    end
  end

  def get_username
    username = input_username
    while authorize_user(username, @admin.employee_names) == false
      bad_user_name
      username = input_username
    end
    return username
  end

end
