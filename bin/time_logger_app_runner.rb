$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), ".." , "lib"))
require 'time_logger_app'
require 'time_logger_input_output'
require 'time_logger_data_repository'

class TimeLoggerAppRunner

  def initialize
    app = TimeLoggerApp.new(TimeLoggerInputOutput.new,
                            TimeLoggerDataRepository.new(time_log_file_name: "files/timelog.csv",
                                                        clients_file_name: "files/clients.csv",
                                                        employees_file_name: "files/employees.csv"))
    app.run
  end

end

runner = TimeLoggerAppRunner.new
