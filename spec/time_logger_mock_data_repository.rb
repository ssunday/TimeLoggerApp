class TimeLoggerMockDataRepository

  def initialize(filenames = {})
    @time_log = []
    @employees = []
    @clients = []
    initialize_employee_file
  end

  def log_time(data_to_be_logged)
    @time_log << data_to_be_logged
  end

  def add_employee(employee_data)
    @employees << employee_data
  end

  def add_client(client_name)
    @clients << client_name
  end

  def client_names
    @clients.flatten
  end

  def employee_names
    @employees.collect(&:first)
  end

  def employee_names_and_hours_for_current_month
    @time_log.collect {|ind|
      if DateTime.parse(ind[1]).month == Date.today.month && DateTime.parse(ind[1]).year == Date.today.year
            [ind[0], ind [2].to_i]
      end}.compact
  end

  def time_codes_and_hours_for_current_month
    @time_log.collect {|ind|
      if DateTime.parse(ind[1]).month == Date.today.month && DateTime.parse(ind[1]).year == Date.today.year
            [ind[3], ind[2].to_i]
      end}.compact
  end

  def time_codes_and_hours_for_current_month_and_username(username)
    @time_log.collect {|ind|
      if DateTime.parse(ind[1]).month == Date.today.month && DateTime.parse(ind[1]).year == Date.today.year \
        && username.eql?(ind[0])
            [ind[3], ind[2].to_i]
      end}.compact
  end

  def client_names_and_hours_for_current_month
    @time_log.collect {|ind|
        if DateTime.parse(ind[1]).month == Date.today.month && DateTime.parse(ind[1]).year == Date.today.year
            [ind[4], ind[2].to_i]
        end}.compact
  end

  def client_names_and_hours_for_current_month_and_username(username)
    @time_log.collect {|ind|
        if DateTime.parse(ind[1]).month == Date.today.month && DateTime.parse(ind[1]).year == Date.today.year \
          && username.eql?(ind[0])
            [ind[4], ind[2].to_i]
        end}.compact
  end

  def dates_and_hours_for_current_month_and_username(username)
    @time_log.collect {|ind|
        if DateTime.parse(ind[1]).month == Date.today.month && DateTime.parse(ind[1]).year == Date.today.year \
          && username.eql?(ind[0])
            [DateTime.parse(ind[1]).strftime('%-d/%-m/%Y'), ind[2].to_i]
        end}.compact
  end

  def get_list_of_dates_worked_in_month_by_user(username)
    dates = []
    @time_log.each do |entry|
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
    @employees.collect {|ind| [ind[0], ind[1].eql?("true")]}.compact
  end

  def read_time_log_data
    @time_log
  end

  def clear_data
    clear_time_log_data
    clear_client_file
    clear_employees_file
  end

  def clear_time_log_data
    @time_log = []
  end

  def clear_client_file
    @clients = []
  end

  def clear_employees_file
    @employees = []
  end

  private

  def default_admin
    default_admin_information = ["default_admin", true]
    @employees << default_admin_information
  end

  def initialize_employee_file
    if @employees.length == 0
      default_admin
    end
  end

end
