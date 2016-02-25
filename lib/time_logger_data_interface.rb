require 'time_logger_data_repository'

class TimeLoggerDataInterface

  def initialize(filenames = {})
    @data_repository = TimeLoggerDataRepository.new(time_log_file_name: filenames.fetch(:time_log_file_name, "files/timelog.csv"),
                                        clients_file_name: filenames.fetch(:clients_file_name, "files/clients.csv"),
                                        employees_file_name: filenames.fetch(:employees_file_name, "files/employees.csv"))
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
    get_attribute_and_hours_from_time_logged_in_current_month(0)
  end

  def time_codes_and_hours_for_current_month
    get_attribute_and_hours_from_time_logged_in_current_month(3)
  end

  def time_codes_and_hours_for_current_month_and_username(username)
    get_attribute_and_hours_from_time_logged_in_current_month_and_for_specific_user(3,username)
  end

  def client_names_and_hours_for_current_month
    get_attribute_and_hours_from_time_logged_in_current_month(4)
  end

  def client_names_and_hours_for_current_month_and_username(username)
    get_attribute_and_hours_from_time_logged_in_current_month_and_for_specific_user(4,username)
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
      if entry[0].eql?(username) && date_in_current_month?(entry[1])
        dates << entry[1]
      end
    end
    dates = dates.map {|s| DateTime.parse(s)}.sort
    dates.map {|date| date.strftime('%-d/%-m/%Y')}.uniq
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

  def get_attribute_and_hours_from_time_logged_in_current_month(specific_attribute_column_index)
    get_all_time_logged.collect {|time_logged_information|
        if date_in_current_month?(time_logged_information[1])
            [time_logged_information[specific_attribute_column_index], time_logged_information[2].to_i]
        end}.compact
  end

  def get_attribute_and_hours_from_time_logged_in_current_month_and_for_specific_user(specific_attribute_column_index, username)
    get_all_time_logged.collect {|time_logged_information|
        if date_in_current_month?(time_logged_information[1]) && username.eql?(time_logged_information[0])
            [time_logged_information[specific_attribute_column_index], time_logged_information[2].to_i]
        end}.compact
  end

end
