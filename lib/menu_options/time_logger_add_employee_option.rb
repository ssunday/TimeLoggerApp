require "time_logger_menu_option"

class TimeLoggerAddEmployeeOption < TimeLoggerAppMenuOption

  def execute(data_logging, io, username)
    employee_data = io.get_employee_info(data_logging.employee_names)
    data_logging.add_employee(employee_data)
  end

  def to_s
    "Add Employee"
  end

end
