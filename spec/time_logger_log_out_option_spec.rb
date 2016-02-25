require "menu_options/time_logger_log_out_option"
require "time_logger_mock_io"
require "time_logger_mock_data_repository"

describe TimeLoggerAddEmployeeOption do

  before do
    @mock_io = TimeLoggerMockIO.new
    @mock_data_repository = TimeLoggerMockDataRepository.new
    @logout = TimeLoggerLogoutOption.new
    @username = "jill"
  end

  it "#to_s returns string" do
    expect(@logout.to_s).to be_an_instance_of(String)
  end

  it "#execute returns false" do
    expect(@logout.execute(@mock_data_repository, @mock_io, @username)).to eql false
  end

end
