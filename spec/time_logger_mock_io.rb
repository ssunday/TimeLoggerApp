class TimeLoggerMockIO

  attr_writer :username, :client_name, :client_name_index, :date, :hours, \
              :timecode_index, :employee_name, :employee_is_admin, \
              :option

  def initialize
    @username = "test"
    @client_name_index = 0
    @date = "2/2/2016"
    @hours = 5
    @client_name = "Foo"
    @timecode_index = 1
    @employee_name = "John"
    @employee_is_admin = "false"
    @option = 1
  end

  def welcome_message
  end

  def end_message
  end

  def input_username
    @username
  end

  def bad_user_name
  end

  def specify_date
    @date
  end

  def hours_worked
    @hours
  end

  def select_timecode(available_timecodes)
    @timecode_index
  end

  def select_client(clients)
    @client_name_index
  end

  def select_option(menu_length)
    @option
  end

  def bad_option
  end

  def get_employee_info
    [@employee_name, @employee_is_admin]
  end

  def get_client_name
    @client_name
  end

  def display_hours_worked_in_month(date_list, hours_worked_in_each)
  end

  def display_hours_worked_per_project(timecodes, hours_worked_for_each)
  end

  def display_hours_worked_per_client(client_names, hours_worked_for_each)
  end

  def display_hours_worked_by_employee(employee_names, hours_worked_by_each)
  end

end
