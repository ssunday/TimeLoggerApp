require "time_logger_data_logging"

describe TimeLoggerDataLogging do

  def no_client_log
    username = "Test1"
    date = "2/15/2016"
    hours = "4"
    timecode = "PTO"
    @logger.log_time(username: username, date: date, hours: hours, timecode: timecode)
    [username, date, hours, timecode, nil]
  end

  def client_log
    username = "Test2"
    date = "2/10/2016"
    hours = "2"
    timecode = "Billable Work"
    client = "Bob"
    @logger.log_time(username: username, date: date, hours: hours, timecode: timecode, client: client)
    [username, date, hours, timecode, client]
  end

  before do
    @file_name = "spec/test_files/timelog_test.csv"
    @employees_file_name = "spec/test_files/employee_log.csv"
    @clients_file_name = "spec/test_files/clients_log.csv"
    @logger = TimeLoggerDataLogging.new(time_log_file_name: @file_name,
                                        clients_file_name: @clients_file_name,
                                        employees_file_name: @employees_file_name)
    @logger.clear_data
  end

  it "can save username, date, hours, and timecode to default file" do
    recorded_data = no_client_log
    data = CSV.read(@file_name)
    expect(data[0]).to eql recorded_data
  end

  it "can save username, date, hours, timecode, and client to default file" do
    recorded_data = client_log
    data = CSV.read(@file_name)
    expect(data[0]).to eql recorded_data
  end

  it "can retrieve array of all rows" do
    no_client = no_client_log
    client = client_log
    data = @logger.read_data
    expect(data).to eql [no_client, client]
  end

end
