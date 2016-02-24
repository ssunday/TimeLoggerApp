$LOAD_PATH.unshift(File.dirname(__FILE__))
require "time_logger_admin"
require "time_logger_app_menu_functions"
require "time_logger_app_menu"

class TimeLoggerApp

  include TimeLoggerAdmin
  include TimeLoggerAppMenuFunctions

  def initialize(input_output, data_logging)
    @io = input_output
    @data_logging = data_logging
    @in_use = true
  end

  def run
    @io.welcome_message
    get_username
    assign_whether_admin_or_not
    menu = TimeLoggerMenu.new(@data_logging, @io, @is_admin, @username)
    while @in_use != false
      @io.display_menu(menu.options)
      option = @io.select_option
      @in_use = menu.do_menu_option(option)
    end
  end

  def get_username
    @username = @io.input_username
    while authorize_user(@username, @data_logging.employee_names) == false
      @io.username_is_not_in_system_message
      @username = @io.input_username
    end
  end

  private

  def assign_whether_admin_or_not
    @is_admin = admin_from_authorized_username?(@username, @data_logging.employee_data)
  end

end
