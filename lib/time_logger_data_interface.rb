require 'time_logger_data_repository'

class TimeLoggerDataInterface

  def initialize
    @data_repository = TimeLoggerDataRepository.new
  end

  def log_employee_hours(args = {})
    data_to_be_logged = [args[:username], args[:date_and_time], args[:hours], args[:timecode], args[:client]]
    @data_repository.log_time(data_to_be_logged)
  end


  def add_new_client(client_name)
    @data_repository.add_client([client_name])
  end

  def add_new_employee(args = {})
    employee_data = [args[:employee_name], args[:is_admin]]
    @data_repository.add_employee(employee_data)
  end


  def get_employee_names
    @data_repository.get_employee_data.collect(&:first)
  end

  def get_employee_names_and_whether_they_are_admin
    @data_repository.get_employee_data.collect {|ind| [ind[0], ind[1].eql?("true")]}.compact
  end

  def get_client_names
    @data_repository.client_names.flatten
  end

  def employee_names_and_hours_for_current_month
    get_all_time_logged.collect {|time_logged_information|
      if date_in_current_month?(time_logged_information[1])
            [time_logged_information[0], time_logged_information[2].to_i]
      end}.compact
  end

  def time_codes_and_hours_for_current_month
    get_all_time_logged.collect {|time_logged_information|
      if date_in_current_month?(time_logged_information[1])
            [time_logged_information[3], time_logged_information[2].to_i]
      end}.compact
  end

  def time_codes_and_hours_for_current_month_and_username(username)
    get_all_time_logged.collect {|time_logged_information|
      if date_in_current_month?(time_logged_information[1]) && \
         username.eql?(time_logged_information[0])
            [time_logged_information[3], time_logged_information[2].to_i]
      end}.compact
  end

  def client_names_and_hours_for_current_month
    get_all_time_logged.collect {|time_logged_information|
        if date_in_current_month?(time_logged_information[1])
            [time_logged_information[4], time_logged_information[2].to_i]
        end}.compact
  end

  def client_names_and_hours_for_current_month_and_username(username)
    get_all_time_logged.collect {|time_logged_information|
        if date_in_current_month?(time_logged_information[1]) && \
          username.eql?(time_logged_information[0])
            [time_logged_information[4], time_logged_information[2].to_i]
        end}.compact
  end

  def dates_and_hours_for_current_month_and_username(username)
    get_all_time_logged.collect {|time_logged_information|
        if date_in_current_month?(time_logged_information[1]) && \
          username.eql?(time_logged_information[0])
            [DateTime.parse(time_logged_information[1]).strftime('%-d/%-m/%Y'), time_logged_information[2].to_i]
        end}.compact
  end

  def get_list_of_dates_worked_in_month_by_user(username)
    dates = []
    get_all_time_logged.each do |entry|
      if entry[0].eql?(username)
        if date_in_current_month?(entry[1])
          dates << entry[1]
        end
      end
    end
    dates = dates.map {|s| DateTime.parse(s)}
    dates = dates.sort
    dates = dates.map {|date| date.strftime('%-d/%-m/%Y')}
    dates.uniq
  end

  def get_all_time_logged
    @data_repository.time_log_data
  end

  def clear_all_data
    @data_repository.clear_data
  end

  private

  def date_in_current_month?(date)
    DateTime.parse(date).month == Date.today.month && DateTime.parse(date).year == Date.today.year
  end

end
