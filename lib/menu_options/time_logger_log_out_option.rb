require "time_logger_menu_option"

class TimeLoggerLogoutOption < TimeLoggerAppMenuOption

  def execute(data_logging, io, username)
    io.end_message
    false
  end

  def to_s
    "Log out"
  end

end
