$LOAD_PATH.unshift(File.dirname(__FILE__))

require "time_logger_menu_option"

class TimeLoggerAddClientOption < TimeLoggerMenuOption

  def initialize
    @option_description = "Add Client"
  end

  def execute(data_logging, io, username)
    client_name = io.get_client_name(data_logging.get_client_names)
    data_logging.add_new_client(client_name)
  end

end
