require "time_logger_menu_option"

class TimeLoggerLogoutOption < TimeLoggerMenuOption

  def initialize
    @option_description = "Log out"
  end

  def execute(data_logging, io, username)
    io.end_message
    false
  end

end
