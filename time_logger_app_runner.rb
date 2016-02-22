#move to a bin folder
#set load path
#use plain requires
require_relative "lib/time_logger_app.rb"
require_relative "lib/time_logger_input_output.rb"

class TimeLoggerAppRunner

  def initialize
    app = TimeLoggerApp.new(TimeLoggerInputOutput.new, \
                          employees_file_name: "files/employees.csv", \
                          clients_file_name: "files/clients.csv", \
                          time_log_file_name: "files/timelog.csv")
    app.run
  end

end

runner = TimeLoggerAppRunner.new
