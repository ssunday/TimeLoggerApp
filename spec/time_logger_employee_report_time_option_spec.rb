require "menu_options/time_logger_employee_report_time_option"
require "time_logger_mock_io"
require "time_logger_mock_data_interface"

describe TimeLoggerEmployeeReportTimeOption do

  before do
    @mock_io = TimeLoggerMockIO.new
    @mock_data_interface = TimeLoggerMockDataInterface.new
    @employee_report_time = TimeLoggerEmployeeReportTimeOption.new
    @username = "jill"
  end

  it "#to_s returns string" do
    expect(@employee_report_time.to_s).to be_an_instance_of(String)
  end

  it "#execute returns nil" do
    expect(@employee_report_time.execute(@mock_data_interface, @mock_io, @username)).to eql nil
  end

end
