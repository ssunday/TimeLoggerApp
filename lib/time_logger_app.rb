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
    get_username
    assign_whether_admin_or_not
  end

  def run
    start_app
    while @in_use != false
      @io.display_menu(@menu.options)
      option = @io.select_option
      @in_use = @menu.do_menu_option(option, @username)
    end
  end

  def get_username
    @username = @io.input_username
    while authorize_user(@username, @data_logging.get_employee_names) == false
      @io.username_is_not_in_system_message
      @username = @io.input_username
    end
  end

  private

  def assign_whether_admin_or_not
    is_admin = admin_from_authorized_username?(@username, @data_logging.get_employee_names_and_whether_they_are_admin)
    @menu.assign_menu_based_on_whether_employee_is_admin(is_admin)
  end

end
