class TimeLoggerMockIO

  attr_writer :username, :client_name, :date, :hours, \
              :time_code, :employee_name, :employee_is_admin, \
              :option, :time

  def initialize
    @username = "test"
    @client_name_index = 0
    @date = "2/2/2016"
    @time = "10:10"
    @hours = 5
    @client_name = "Foo"
    @time_code = "PTO"
    @employee_name = "John"
    @employee_is_admin = "false"
    @option = 1
  end

  def display_menu(menu_option)
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

  def specify_time
    @time
  end

  def specify_date
    @date
  end

  def hours_worked
    @hours
  end

  def select_timecode(available_timecodes)
    @time_code
  end

  def select_client(clients)
    @client_name
  end

  def select_option
    @option
  end

  def invalid_option_message
  end

  def specify_date_and_time
    @date + " " + @time
  end

  def get_employee_info(employee_names)
    [@employee_name, @employee_is_admin]
  end

  def get_client_name(client_names)
    [@client_name]
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
