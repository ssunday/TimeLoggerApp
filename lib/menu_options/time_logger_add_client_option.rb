require "time_logger_menu_option"

class TimeLoggerAddClientOption < TimeLoggerAppMenuOption

  def execute(data_logging, io, username)
    client_name = io.get_client_name(data_logging.client_names)
    data_logging.add_client(client_name)
  end

  def to_s
    "Add Client"
  end

end
