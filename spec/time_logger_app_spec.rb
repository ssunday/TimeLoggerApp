require "time_logger_app"
require "time_logger_mock_io"
require "time_logger_mock_data_repository"

describe TimeLoggerApp do

  before do
    @mock_io = TimeLoggerMockIO.new
    @mock_data_repo = TimeLoggerMockDataRepository.new
    @app = TimeLoggerApp.new(@mock_io, @mock_data_repo)
  end

  it "#run returns nil and finishes loop when employee logs out" do
    name = "bob"
    is_admin = "false"
    @mock_io.employee_name = name
    @mock_io.employee_is_admin = is_admin
    @mock_data_repo.add_employee([name,is_admin])
    @mock_io.username = name
    @mock_io.option = TimeLoggerApp::MENU_EMPLOYEE.length
    expect(@app.run).to eql nil
  end

  it "#run returns nil and finishes loop when admin logs out" do
    name = "jane"
    is_admin = "true"
    @mock_io.employee_name = name
    @mock_io.employee_is_admin = is_admin
    @mock_data_repo.add_employee([name,is_admin])
    @mock_io.username = name
    @mock_io.option = TimeLoggerApp::MENU_ADMIN.length
    expect(@app.run).to eql nil
  end

end
