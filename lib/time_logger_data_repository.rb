require "csv"

class TimeLoggerDataRepository

  def initialize(filenames = {})
    @time_log_file_name = filenames[:time_log_file_name]
    @employees_file_name = filenames[:employees_file_name]
    @clients_file_name = filenames[:clients_file_name]
    initialize_employee_file
  end

  def time_log_data
    CSV.read(@time_log_file_name)
  end

  def log_time(data_to_be_logged)
    CSV.open(@time_log_file_name, "ab") do |csv|
      csv << data_to_be_logged
    end
  end

  def add_employee(employee_data)
    CSV.open(@employees_file_name, "ab") do |csv|
      csv << employee_data
    end
  end

  def add_client(client_name)
    CSV.open(@clients_file_name, "ab") do |csv|
      csv << client_name
    end
  end

  def client_names
    CSV.read(@clients_file_name)
  end

  def get_employee_data
    CSV.read(@employees_file_name)
  end

  def read_time_log_data
    CSV.read(@time_log_file_name)
  end

  def clear_data
    clear_time_log_data
    clear_client_file
    clear_employees_file
  end

  def clear_time_log_data
    CSV.open(@time_log_file_name, "w") do |csv|
    end
  end

  def clear_client_file
    CSV.open(@clients_file_name, "w") do |csv|
    end
  end

  def clear_employees_file
    CSV.open(@employees_file_name, "w") do |csv|
    end
  end

  private

  def default_admin
    default_admin_information = ["default_admin", true]
    CSV.open(@employees_file_name, "ab") do |csv|
      csv << default_admin_information
    end
  end

  def initialize_employee_file
    if File.exist?(@employees_file_name) == false || CSV.read(@employees_file_name).length == 0
      default_admin
    end
  end

end
