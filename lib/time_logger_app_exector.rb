require_relative "time_logger_app.rb"
class TimeLoggerAppExecutor

  def initialize
    app = TimeLoggerApp.new
    app.run
  end
  
end

runner = TimeLoggerAppExecutor.new
