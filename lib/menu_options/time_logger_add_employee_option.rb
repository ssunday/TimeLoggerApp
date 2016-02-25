require "time_logger_menu_option"

class TimeLoggerAddEmployeeOption < TimeLoggerMenuOption

  def initialize
    @option_description = "Add Employee"
  end

  def execute(data_logging, io, username)
    employee_name = io.get_employee_username(data_logging.get_employee_names)
    is_admin = io.get_whether_employee_admin
    data_logging.add_new_employee(employee_name: employee_name, is_admin: is_admin)
  end

end
