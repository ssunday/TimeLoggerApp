require "time_logger_data_logging"

describe TimeLoggerDataLogging do

  before do
    @file_name = "tester.csv"
    @logger = TimeLoggerDataLogging.new(@file_name)
    @logger.clear_data
  end

  it "can save date, hours, and timecode to default file" do
    date = "2/15/2016"
    hours = "4"
    timecode = "Billable Work"
    @logger.log_time(date, hours, timecode)
    data = CSV.read(@file_name)
    expect(data[0]).to eql [date, hours, timecode]
  end

end
