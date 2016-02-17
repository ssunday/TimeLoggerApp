require "time_logger_app"
require_relative "time_logger_mock_io.rb"

describe TimeLoggerApp do

  before do
    @app = TimeLoggerApp(TimeLoggerMockIO.new, \
                          employees_file_name: "spec/test_files/employees.csv", \
                          clients_file_name: "spec/test_files/clients.csv", \
                          time_log_file_name: "spec/test_files/timelog.csv")
  end

  it "does stuff" do

  end
  
end
