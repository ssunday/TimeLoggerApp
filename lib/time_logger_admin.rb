require "csv"

class TimeLoggerAdmin

  def initialize(employees_file_name = "files/employees.csv", clients_file_name = "files/clients.csv")
    @employee_file_name = employees_file_name
    @clients_file_name = clients_file_name
  end

  def add_employee(username, is_admin)
    CSV.open(@employee_file_name, "ab") do |csv|
      csv << [username, is_admin]
    end
  end

  def add_client(client_name)
    CSV.open(@clients_file_name, "ab") do |csv|
      csv << [client_name]
    end
  end

  def all_employees_report(time_data)

  end

  def clear_files
    CSV.open(@clients_file_name, "w") do |csv|
    end

    CSV.open(@employee_file_name, "w") do |csv|
    end
  end

end
