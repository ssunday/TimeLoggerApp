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

end
