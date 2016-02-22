$LOAD_PATH.unshift(File.dirname(__FILE__))

require '../lib/time_logger_app'
require '../lib/time_logger_input_output'
require '../lib/time_logger_data_logging'

class TimeLoggerAppRunner

  def initialize
    app = TimeLoggerApp.new(TimeLoggerInputOutput.new,
                            TimeLoggerDataLogging.new(time_log_file_name: "files/timelog.csv",
                                                        clients_file_name: "files/clients.csv",
                                                        employees_file_name: "files/employees.csv"))
    app.run
  end

end

runner = TimeLoggerAppRunner.new
