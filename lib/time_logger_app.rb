$LOAD_PATH.unshift(File.dirname(__FILE__))
require "time_logger_admin"

class TimeLoggerApp

  include TimeLoggerAdmin

  def initialize(input_output, data_logging, menu)
    @io = input_output
    @data_logging = data_logging
    @in_use = true
    @menu = menu
  end

  def start_app
    @io.welcome_message
    get_username_that_is_in_system
    assign_whether_admin_or_not
  end

  def run
    start_app
    app_active_menu_loop
  end

  def app_active_menu_loop
    while app_is_being_used_by_employee?
      @io.display_menu(@menu.options)
      option = @io.select_option
      @in_use = @menu.do_menu_option(option, @username)
    end
  end

  def get_username_that_is_in_system
    @username = @io.input_username
    while username_is_registered_employee?(@username, @data_logging.get_employee_names) == false
      @io.username_is_not_in_system_message
      @username = @io.input_username
    end
  end

  private

  def assign_whether_admin_or_not
    is_admin = registered_employee_is_admin?(@username, @data_logging.get_employee_names_and_whether_they_are_admin)
    @menu.assign_menu_based_on_whether_employee_is_admin(is_admin)
  end

  def app_is_being_used_by_employee?()
    @in_use != false
  end

end
