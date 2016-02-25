require "menu_options/time_logger_log_hours_menu_option"
require "time_logger_mock_io"
require "time_logger_mock_data_repository"

describe TimeLoggerLogHoursMenuOption do

  before do
    @mock_io = TimeLoggerMockIO.new
    @mock_data_repository = TimeLoggerMockDataRepository.new
    @log_hours = TimeLoggerLogHoursMenuOption.new
    @username = "jameson"
  end

  it "#to_s returns string" do
    expect(@log_hours.to_s).to be_an_instance_of(String)
  end

  it "#execute returns nested array containing time logged" do
    expect(@log_hours.execute(@mock_data_repository, @mock_io, @username)).to eql [[@username,
                                                                        @mock_io.date + " " + @mock_io.time,
                                                                        @mock_io.hours,
                                                                        @mock_io.time_code,
                                                                        @mock_io.client_name]]
  end

end
