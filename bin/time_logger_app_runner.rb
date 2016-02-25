$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), ".." , "lib"))

require 'time_logger_app'
require 'time_logger_input_output'
require 'time_logger_data_interface'
require "time_logger_app_menu"

class TimeLoggerAppRunner

  def initialize
    io = TimeLoggerInputOutput.new
    data_interface = TimeLoggerDataInterface.new
    menu = TimeLoggerMenu.new(data_interface, io)
    app = TimeLoggerApp.new(io,
                            data_interface,
                            menu)
    app.run
  end

end

runner = TimeLoggerAppRunner.new
