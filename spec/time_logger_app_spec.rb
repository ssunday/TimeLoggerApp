require "time_logger_app"
require_relative "time_logger_mock_io.rb"
require "csv"

describe TimeLoggerApp do

  def clear_files
    CSV.open(@client_test_file, "w") do |csv|
    end

    CSV.open(@employee_test_file, "w") do |csv|
    end

    CSV.open(@time_log_test_file, "w") do |csv|
    end
  end

  before do

    @employee_test_file = "spec/test_files/employees.csv"
    @client_test_file = "spec/test_files/clients.csv"
    @time_log_test_file = "spec/test_files/timelog.csv"

    clear_files

    @mock_io = TimeLoggerMockIO.new
    @app = TimeLoggerApp.new(@mock_io, \
                          employees_file_name: @employee_test_file, \
                          clients_file_name: @client_test_file, \
                          time_log_file_name: @time_log_test_file)
  end

  it "#admin_add_client adds client to file" do
    @mock_io.client_name = "Foo"
    @app.admin_add_client
    expect(CSV.read(@client_test_file)[0]).to eql ["Foo"]
  end

end
