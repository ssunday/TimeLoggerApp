$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), ".." , "lib"))

require 'time_logger_app'
require 'time_logger_input_output'
require 'time_logger_data_repository'
require 'time_logger_data_interface'
require "time_logger_app_menu"

class TimeLoggerAppRunner

  def initialize
    io = TimeLoggerInputOutput.new
    #data_interface = TimeLoggerDataInterface.new
    data_repository = TimeLoggerDataRepository.new(time_log_file_name: "files/timelog.csv",
                                clients_file_name: "files/clients.csv",
                                employees_file_name: "files/employees.csv")
    menu = TimeLoggerMenu.new(data_repository, io)
    app = TimeLoggerApp.new(io,
                            data_repository,
                            menu)
    app.run
  end

end

runner = TimeLoggerAppRunner.new
