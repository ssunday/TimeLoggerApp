require "csv"

class TimeLoggerDataRepository

  def initialize(filenames = {})
    @time_log_file_name = filenames[:time_log_file_name]
    @employees_file_name = filenames[:employees_file_name]
    @clients_file_name = filenames[:clients_file_name]
    initialize_employee_file
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
    CSV.read(@clients_file_name).flatten
  end

  def employee_names
    time_log_data = CSV.read(@employees_file_name)
    time_log_data.collect(&:first)
  end

  def employee_names_and_hours_for_current_month
    time_log_data = CSV.read(@time_log_file_name)
    time_log_data.collect {|ind|
      if DateTime.parse(ind[1]).month == Date.today.month && DateTime.parse(ind[1]).year == Date.today.year
            [ind[0], ind [2].to_i]
      end}.compact
  end

  def time_codes_and_hours_for_current_month
    time_log_data = CSV.read(@time_log_file_name)
    time_log_data.collect {|ind|
      if DateTime.parse(ind[1]).month == Date.today.month && DateTime.parse(ind[1]).year == Date.today.year
            [ind[3], ind[2].to_i]
      end}.compact
  end

  def time_codes_and_hours_for_current_month_and_username(username)
    time_log_data = CSV.read(@time_log_file_name)
    time_log_data.collect {|ind|
      if DateTime.parse(ind[1]).month == Date.today.month && DateTime.parse(ind[1]).year == Date.today.year \
        && username.eql?(ind[0])
            [ind[3], ind[2].to_i]
      end}.compact
  end

  def client_names_and_hours_for_current_month
    time_log_data = CSV.read(@time_log_file_name)
    time_log_data.collect {|ind|
        if DateTime.parse(ind[1]).month == Date.today.month && DateTime.parse(ind[1]).year == Date.today.year
            [ind[4], ind[2].to_i]
        end}.compact
  end

  def client_names_and_hours_for_current_month_and_username(username)
    time_log_data = CSV.read(@time_log_file_name)
    time_log_data.collect {|ind|
        if DateTime.parse(ind[1]).month == Date.today.month && DateTime.parse(ind[1]).year == Date.today.year \
          && username.eql?(ind[0])
            [ind[4], ind[2].to_i]
        end}.compact
  end

  def dates_and_hours_for_current_month_and_username(username)
    time_log_data = CSV.read(@time_log_file_name)
    time_log_data.collect {|ind|
        if DateTime.parse(ind[1]).month == Date.today.month && DateTime.parse(ind[1]).year == Date.today.year \
          && username.eql?(ind[0])
            [DateTime.parse(ind[1]).strftime('%-d/%-m/%Y'), ind[2].to_i]
        end}.compact
  end

  def get_list_of_dates_worked_in_month_by_user(username)
    time_log_data = CSV.read(@time_log_file_name)
    dates = []
    time_log_data.each do |entry|
      if entry[0].eql?(username)
        date = DateTime.parse(entry[1])
        if date.month == Date.today.month && date.year == Date.today.year
          dates << entry[1]
        end
      end
    end
    dates = dates.map {|s| DateTime.parse(s)}
    dates = dates.sort
    dates = dates.map {|date| date.strftime('%-d/%-m/%Y')}
    dates.uniq
  end

  def employee_data
    employee_data = CSV.read(@employees_file_name)
    employee_data.collect {|ind| [ind[0], ind[1].eql?("true")]}.compact
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
