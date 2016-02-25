require "time_logger_data_interface"

describe TimeLoggerDataInterface do

  def no_client_log
    username = "Test1"
    date = Date.today.strftime('%-d/%-m/%Y')
    date = date + " 12:00"
    hours = "4"
    timecode = "PTO"
    client = nil
    @interface.log_employee_hours(username: username, date_and_time: date, hours: hours, timecode: timecode, client: client)
    [username, date, hours, timecode, client]
  end

  def client_log
    username = "Test2"
    date = Date.today.strftime('%-d/%-m/%Y')
    date = date + " 12:00"
    hours = "2"
    timecode = "Billable Work"
    client = "Bob"
    @interface.log_employee_hours(username: username, date_and_time: date, hours: hours, timecode: timecode, client: client)
    [username, date, hours, timecode, client]
  end

  before do
    @file_name = "spec/test_files/timelog.csv"
    @employees_file_name = "spec/test_files/employees.csv"
    @clients_file_name = "spec/test_files/clients.csv"
    @interface = TimeLoggerDataInterface.new(time_log_file_name: @file_name,
                                        clients_file_name: @clients_file_name,
                                        employees_file_name: @employees_file_name)
    @interface.clear_all_data
  end

  describe "#log_employee_hours" do

    it "can save username, date, hours, and timecode to default file" do
      recorded_data = no_client_log
      expect(@interface.get_all_time_logged).to eql [recorded_data]
    end

    it "can save username, date, hours, timecode, and client to default file" do
      recorded_data = client_log
      expect(@interface.get_all_time_logged).to eql [recorded_data]
    end

  end

  it "#add_new_client" do
    client_name = "Generic Company Name"
    @interface.add_new_client(client_name)
    expect(@interface.get_client_names).to eql [client_name]
  end

  it "#add_new_employee" do
    employee = "sasunday"
    is_admin = false
    @interface.add_new_employee(employee_name: employee, is_admin: is_admin)
    expect(@interface.get_employee_names_and_whether_they_are_admin[0]).to eql [employee,is_admin]
  end

  it "#client_names_and_hours_for_current_month returns list of client names and hours for current month" do
    client = client_log
    expect(@interface.client_names_and_hours_for_current_month).to eql [[client[4], client[2].to_i]]
  end

  describe "#client_names_and_hours_for_current_month_and_username" do

    it "returns empty list when username does not have any matches" do
      client = client_log
      expect(@interface.client_names_and_hours_for_current_month_and_username("Someone else")).to eql []
    end

    it "returns list of client names and hours for current month and specific username" do
      client = client_log
      expect(@interface.client_names_and_hours_for_current_month_and_username(client[0])).to eql [[client[4], client[2].to_i]]
    end

  end

  it "#time_codes_and_hours_for_current_month returns list of timecodes and hours for current month" do
    client = client_log
    no_client = no_client_log
    expect(@interface.time_codes_and_hours_for_current_month).to eql [[client[3], client[2].to_i], [no_client[3], no_client[2].to_i]]
  end

  it "#time_codes_and_hours_for_current_month_and_username returns list of timecodes and hours for current month and specific username" do
    client = client_log
    no_client = no_client_log
    expect(@interface.time_codes_and_hours_for_current_month_and_username(client[0])).to eql [[client[3], client[2].to_i]]
  end

  it "#get_employee_names_and_hours_for_current_month returns list of employees and hours for current month" do
    client = client_log
    no_client = no_client_log
    expect(@interface.get_employee_names_and_hours_for_current_month).to eql [[client[0], client[2].to_i], [no_client[0], no_client[2].to_i]]
  end

  it "#get_employee_names returns list of just employee_names" do
    employee1 = ["sasunday", false]
    employee2 = ["john", true]
    @interface.add_new_employee(employee_name: employee1[0], is_admin: employee1[1])
    @interface.add_new_employee(employee_name: employee2[0], is_admin: employee2[1])
    expect(@interface.get_employee_names).to eql [employee1[0], employee2[0]]
  end

  it "#get_employee_names_and_whether_they_are_admin returns nested array of employee names whether they are admin" do
    employee1 = ["sasunday", false]
    employee2 = ["john", true]
    @interface.add_new_employee(employee_name: employee1[0], is_admin: employee1[1])
    @interface.add_new_employee(employee_name: employee2[0], is_admin: employee2[1])
    expect(@interface.get_employee_names_and_whether_they_are_admin).to eql [employee1, employee2]
  end

  it "#get_client_names returns one-d array of client names" do
    client_name1 = "Generic Company Name"
    client_name2 = "Foogle"
    @interface.add_new_client(client_name1)
    @interface.add_new_client(client_name2)
    expect(@interface.get_client_names).to eql [client_name1, client_name2]
  end

end
