require "time_logger_app"
require "time_logger_mock_io"
require "time_logger_data_repository"
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
    @app = TimeLoggerApp.new(@mock_io,
    TimeLoggerDataRepository.new(time_log_file_name: @time_log_test_file,
                                clients_file_name: @client_test_file,
                                employees_file_name: @employee_test_file))
  end

  it "#admin_add_client adds client to file" do
    name = ["Foo"]
    @mock_io.client_name = name
    @app.admin_add_client
    expect(CSV.read(@client_test_file)[0]).to eql name
  end

  it "#admin_add_employee adds employee to file" do
    name = "bob"
    is_admin = "false"
    @mock_io.employee_name = name
    @mock_io.employee_is_admin = is_admin
    @app.admin_add_employee
    expect(CSV.read(@employee_test_file)[1]).to eql [name, is_admin] #is 1 because default admin is first
  end

  it "#employee_log_time logs the specified time into the file" do
    name = "janice"
    hours = "10"
    date = "1/1/2015"
    timecode = TimeLoggerApp::AVAILABLE_TIMECODES[1]
    time = "8:19"
    @mock_io.employee_name = name
    @app.admin_add_employee
    @mock_io.username = name
    @app.get_username
    @mock_io.hours = hours
    @mock_io.date = date
    @mock_io.time = time
    @mock_io.time_code = timecode
    @app.employee_log_time
    expect(CSV.read(@time_log_test_file)[0]).to eql [name, date + " " + time, hours, timecode, nil]
  end

  it "#do_menu_option returns false when employee selects logout" do
    name = "bob"
    is_admin = "false"
    @mock_io.employee_name = name
    @mock_io.employee_is_admin = is_admin
    @app.admin_add_employee
    @mock_io.username = name
    @mock_io.option = TimeLoggerApp::MENU_EMPLOYEE.length
    expect(@app.do_menu_option(TimeLoggerApp::MENU_EMPLOYEE.length, TimeLoggerApp::MENU_EMPLOYEE.length)).to eql false
  end

  it "#do_menu_option returns false when admin selects logout" do
    name = "jane"
    is_admin = "true"
    @mock_io.employee_name = name
    @mock_io.employee_is_admin = is_admin
    @app.admin_add_employee
    @mock_io.username = name
    @mock_io.option = TimeLoggerApp::MENU_ADMIN.length
    expect(@app.do_menu_option(TimeLoggerApp::MENU_ADMIN.length, TimeLoggerApp::MENU_ADMIN.length)).to eql false
  end

end
