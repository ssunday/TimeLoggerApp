require "time_logger_admin"

describe TimeLoggerAdmin do

  before do
    @employee_file_name = "spec/test_files/employee_test.csv"
    @client_file_name = "spec/test_files/client_test.csv"
    @admin = TimeLoggerAdmin.new(@employee_file_name, @client_file_name)
    @admin.clear_files
  end

  it "adds a default admin" do
    default_admin = TimeLoggerAdmin.new(@employee_file_name, @client_file_name)
    data = CSV.read(@employee_file_name)
    expect(data[0]).to eql ["default_admin", "true"]
  end

  it "can add an employee to the file" do
    employee = ["sasunday", "false"]
    @admin.add_employee(employee)
    data = CSV.read(@employee_file_name)
    expect(data[0]).to eql employee
  end

  it "can add new client to the file" do
    client_name = "Generic Company Name"
    @admin.add_client(client_name)
    data = CSV.read(@client_file_name)
    expect(data[0]).to eql [client_name]
  end

end
