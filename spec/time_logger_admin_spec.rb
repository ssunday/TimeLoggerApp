require "time_logger_admin"

describe TimeLoggerAdmin do

  before do
    @employee_file_name = "spec/test_files/employee_test.csv"
    @client_file_name = "spec/test_files/client_test.csv"
    @admin = TimeLoggerAdmin.new(@employee_file_name, @client_file_name)
    @admin.clear_client_file
    @admin.clear_employees_file
  end

  it "adds a default admin" do
    default_admin = TimeLoggerAdmin.new(@employee_file_name, @client_file_name)
    data = CSV.read(@employee_file_name)
    expect(data[0]).to eql ["default_admin", "true"]
  end

  it "#add_employee" do
    employee = ["sasunday", "false"]
    @admin.add_employee(employee)
    data = CSV.read(@employee_file_name)
    expect(data[0]).to eql employee
  end

  it "#add_client" do
    client_name = "Generic Company Name"
    @admin.add_client(client_name)
    data = CSV.read(@client_file_name)
    expect(data[0]).to eql [client_name]
  end

  it "#clear_client_file" do
    client_name = "Generic Company Name"
    @admin.add_client(client_name)
    @admin.clear_client_file
    expect(CSV.read(@client_file_name).length).to eql 0
  end

  it "#clear_employees_file" do
    employee = ["sasunday", "false"]
    @admin.add_employee(employee)
    @admin.clear_employees_file
    expect(CSV.read(@employee_file_name).length).to eql 0
  end

  it "#is_admin_from_user_name verifies if user is admin or not" do
    employee = ["sasunday", "true"]
    @admin.add_employee(employee)
    expect(@admin.is_admin_from_user_name(employee[0])).to eql true
  end

end
