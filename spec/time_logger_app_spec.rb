require "time_logger_app"
require "time_logger_mock_io"
require "time_logger_mock_data_repository"
require "csv"

describe TimeLoggerApp do

  before do
    @mock_io = TimeLoggerMockIO.new
    @mock_data_repo = TimeLoggerMockDataRepository.new
    @app = TimeLoggerApp.new(@mock_io, @mock_data_repo)
  end

  it "#admin_add_client adds client to file" do
    name = ["Foo"]
    @mock_io.client_name = name
    @app.admin_add_client
    expect(@mock_data_repo.client_names).to eql name
  end

  it "#admin_add_employee adds employee to file" do
    name = "bob"
    @mock_io.employee_name = name
    @app.admin_add_employee
    expect(@mock_data_repo.employee_names[1]).to eql name #is 1 because default admin is first
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
    expect(@mock_data_repo.read_time_log_data[0]).to eql [name, date + " " + time, hours, timecode, nil]
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
