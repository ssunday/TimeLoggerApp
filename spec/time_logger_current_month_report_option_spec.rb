require "menu_options/time_logger_employee_report_time_option"
require "time_logger_mock_io"
require "time_logger_mock_data_repository"

describe TimeLoggerCurrentMonthReportOption do

  before do
    @mock_io = TimeLoggerMockIO.new
    @mock_data_repository = TimeLoggerMockDataRepository.new
    @report_month = TimeLoggerCurrentMonthReportOption.new
    @username = "jill"
  end

  it "#to_s returns string" do
    expect(@report_month.to_s).to be_an_instance_of(String)
  end

  it "#execute returns nil" do
    expect(@report_month.execute(@mock_data_repository, @mock_io, @username)).to eql nil
  end

end
