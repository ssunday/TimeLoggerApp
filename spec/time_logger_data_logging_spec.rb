require "time_logger_data_logging"

describe TimeLoggerDataLogging do

  def no_client_log
    username = "Test1"
    date = Date.today.strftime('%-d/%-m/%Y')
    hours = "4"
    timecode = "PTO"
    @logger.log_time([username, date, hours, timecode, nil])
    [username, date, hours, timecode, nil]
  end

  def client_log
    username = "Test2"
    date = Date.today.strftime('%-d/%-m/%Y')
    hours = "2"
    timecode = "Billable Work"
    client = "Bob"
    @logger.log_time([username, date, hours, timecode, client])
    [username, date, hours, timecode, client]
  end

  before do
    @file_name = "spec/test_files/timelog.csv"
    @employees_file_name = "spec/test_files/employees.csv"
    @clients_file_name = "spec/test_files/clients.csv"
    @logger = TimeLoggerDataLogging.new(time_log_file_name: @file_name,
                                        clients_file_name: @clients_file_name,
                                        employees_file_name: @employees_file_name)
    @logger.clear_data
  end

  describe "#log_time" do

    it "can save username, date, hours, and timecode to default file" do
      recorded_data = no_client_log
      expect(@logger.read_time_log_data[0]).to eql recorded_data
    end

    it "can save username, date, hours, timecode, and client to default file" do
      recorded_data = client_log
      expect(@logger.read_time_log_data[0]).to eql recorded_data
    end

  end


  it "can retrieve array of all rows" do
    no_client = no_client_log
    client = client_log
    expect(@logger.read_time_log_data).to eql [no_client, client]
  end

  it "adds a default admin" do
    default_admin = TimeLoggerDataLogging.new(time_log_file_name: @file_name,
                                              clients_file_name: @clients_file_name,
                                              employees_file_name: @employees_file_name)
    expect(@logger.employee_data[0]).to eql ["default_admin", "true"]
  end


  it "#add_employee" do
    employee = ["sasunday", "false"]
    @logger.add_employee(employee)
    expect(@logger.employee_data[0]).to eql employee
  end

  it "#client_names_and_hours_for_current_month returns list of client names and hours for current month" do
    client = client_log
    expect(@logger.client_names_and_hours_for_current_month).to eql [[client[4], client[2].to_i]]
  end

  describe "#client_names_and_hours_for_current_month_and_username" do

    it "returns empty list when username does not have any matches" do
      client = client_log
      expect(@logger.client_names_and_hours_for_current_month_and_username("Someone else")).to eql []
    end

    it "returns list of client names and hours for current month and specific username" do
      client = client_log
      expect(@logger.client_names_and_hours_for_current_month_and_username(client[0])).to eql [[client[4], client[2].to_i]]
    end

  end


  it "#time_codes_and_hours_for_current_month returns list of timecodes and hours for current month" do
    client = client_log
    no_client = no_client_log
    expect(@logger.time_codes_and_hours_for_current_month).to eql [[client[3], client[2].to_i], [no_client[3], no_client[2].to_i]]
  end

  it "#time_codes_and_hours_for_current_month_and_username returns list of timecodes and hours for current month and specific username" do
    client = client_log
    no_client = no_client_log
    expect(@logger.time_codes_and_hours_for_current_month_and_username(client[0])).to eql [[client[3], client[2].to_i]]
  end

  it "#employee_names_and_hours_for_current_month returns list of employees and hours for current month" do
    client = client_log
    no_client = no_client_log
    expect(@logger.employee_names_and_hours_for_current_month).to eql [[client[0], client[2].to_i], [no_client[0], no_client[2].to_i]]
  end

  it "#employee_names returns list of just employee_names" do
    employee1 = ["sasunday", "false"]
    employee2 = ["john", "true"]
    @logger.add_employee(employee1)
    @logger.add_employee(employee2)
    expect(@logger.employee_names).to eql [employee1[0], employee2[0]]
  end

  it "#add_client" do
    client_name = ["Generic Company Name"]
    @logger.add_client(client_name)
    expect(@logger.client_names).to eql client_name
  end

  it "#client_names returns one-d array of client names" do
    client_name1 = ["Generic Company Name"]
    client_name2 = ["Foogle"]
    @logger.add_client(client_name1)
    @logger.add_client(client_name2)
    expect(@logger.client_names).to eql [client_name1[0], client_name2[0]]
  end

  it "#clear_client_file" do
    client_name = ["Generic Company Name"]
    @logger.add_client(client_name)
    @logger.clear_client_file
    expect(@logger.client_names.length).to eql 0
  end

  it "#clear_employees_file" do
    employee = ["sasunday", "false"]
    @logger.add_employee(employee)
    @logger.clear_employees_file
    expect(@logger.employee_data.length).to eql 0
  end

end
