class TimeLoggerAddEmployeeOption

  def execute(data_logging, io, username, timecodes)
    employee_data = io.get_employee_info(data_logging.employee_names)
    data_logging.add_employee(employee_data)
  end

  def to_s
    "Add Employee"
  end

end
