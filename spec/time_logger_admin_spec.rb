require "time_logger_admin"

describe TimeLoggerAdmin do

  before do
    @employee_file_name = "spec/test_files/employee_test.csv"
    @client_file_name = "spec/test_files/client_test.csv"
    @admin = TimeLoggerAdmin.new(@employee_file_name, @client_file_name)
    @admin.clear_files
  end

  it "can add an employee to the file" do
    user_name = "sasunday"
    admin = "no"
    @admin.add_employee(user_name, admin)
    data = CSV.read(@employee_file_name)
    expect(data[0]).to eql [user_name, admin]
  end

  it "can add new client to the file" do
    client_name = "Generic Company Name"
    @admin.add_client(client_name)
    data = CSV.read(@client_file_name)
    expect(data[0]).to eql [client_name]
  end

end
