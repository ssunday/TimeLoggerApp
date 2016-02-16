require_relative "lib/time_logger_app.rb"
require_relative "lib/time_logger_input_output.rb"

class TimeLoggerAppRunner

  def initialize
    app = TimeLoggerApp.new(TimeLoggerInputOutput.new)
    app.run
  end

end

runner = TimeLoggerAppRunner.new
