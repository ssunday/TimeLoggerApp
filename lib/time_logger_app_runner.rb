require_relative "time_logger_app.rb"
class TimeLoggerAppRunner

  def initialize
    app = TimeLoggerApp.new
    app.run
  end

end

runner = TimeLoggerAppRunner.new
