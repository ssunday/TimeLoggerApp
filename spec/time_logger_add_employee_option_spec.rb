require "menu_options/time_logger_add_employee_option"
require "time_logger_mock_io"
require "time_logger_mock_data_interface"

describe TimeLoggerAddEmployeeOption do

  before do
    @mock_io = TimeLoggerMockIO.new
    @mock_data_interface = TimeLoggerMockDataInterface.new
    @add_employee_option = TimeLoggerAddEmployeeOption.new
  end

  it "#to_s returns string" do
    expect(@add_employee_option.to_s).to be_an_instance_of(String)
  end

  it "#execute adds employee to data repository" do
    name = "bob"
    is_admin = "true"
    @mock_io.employee_name = name
    @mock_io.employee_is_admin = is_admin
    username = "jill"
    @add_employee_option.execute(@mock_data_interface, @mock_io, username)
    expect(@mock_data_interface.get_employee_names_and_whether_they_are_admin[1]).to eql [name, is_admin.eql?("true")]
  end

end
