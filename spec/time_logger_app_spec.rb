require "time_logger_app"
require "time_logger_mock_io"
require "time_logger_mock_data_interface"
require "time_logger_mock_menu"

describe TimeLoggerApp do

  before do
    @mock_io = TimeLoggerMockIO.new
    @mock_data_interface = TimeLoggerMockDataInterface.new
    @mock_menu = TimeLoggerMockMenu.new(@mock_data_repo, @mock_io)
    @app = TimeLoggerApp.new(@mock_io, @mock_data_interface, @mock_menu)
  end

  it "#run returns nil and finishes loop when employee logs out" do
    name = "bob"
    is_admin = "false"
    @mock_io.employee_name = name
    @mock_io.employee_is_admin = is_admin
    @mock_data_interface.add_new_employee(employee_name: name, is_admin: is_admin)
    @mock_menu.assign_menu_based_on_whether_employee_is_admin(is_admin.eql?("true"))
    @mock_io.username = name
    @mock_io.option = 3
    expect(@app.run).to eql nil
  end

  it "#run returns nil and finishes loop when admin logs out" do
    name = "jane"
    is_admin = "true"
    @mock_io.employee_name = name
    @mock_io.employee_is_admin = is_admin
    @mock_data_interface.add_new_employee(employee_name: name, is_admin: is_admin)
    @mock_io.username = name
    @mock_menu.assign_menu_based_on_whether_employee_is_admin(is_admin.eql?("true"))
    @mock_io.option = @mock_menu.options.length
    expect(@app.run).to eql nil
  end

end
