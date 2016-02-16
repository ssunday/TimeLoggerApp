require "csv"

class TimeLoggerAdmin

  def initialize(employees_file_name = "files/employees.csv", clients_file_name = "files/clients.csv")
    @employees_file_name = employees_file_name
    @clients_file_name = clients_file_name
    initialize_employee_file
  end


  def add_employee(employee_data)
    CSV.open(@employees_file_name, "ab") do |csv|
      csv << employee_data
    end
  end

  def add_client(client_name)
    CSV.open(@clients_file_name, "ab") do |csv|
      csv << [client_name]
    end
  end

  def client_names
    CSV.read(@clients_file_name).flatten
  end

  def employee_names
    employee_data = CSV.read(@employees_file_name)
    employee_data.collect(&:first)
  end

  def is_admin_from_user_name(username)
    employee_data = CSV.read(@employees_file_name)
    employee_data.each do |set|
      if username.eql?(set[0])
        return set[1].eql?("true")
      end
    end
  end

  def clear_files
    CSV.open(@clients_file_name, "w") do |csv|
    end

    CSV.open(@employees_file_name, "w") do |csv|
    end
  end

  private

  def default_admin
    CSV.open(@employees_file_name, "ab") do |csv|
      csv << ["default_admin", true]
    end
  end

  def initialize_employee_file
    if File.exist?(@employees_file_name) == false \
      || CSV.read(@employees_file_name).length == 0
      default_admin
    end
  end

end
