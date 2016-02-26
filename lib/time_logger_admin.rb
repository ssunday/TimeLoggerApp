module TimeLoggerAdmin

  def username_is_registered_employee?(username, employee_names)
    employee_names.include?(username)
  end

  def registered_employee_is_admin?(username, employee_data)
    username_index = employee_data.index(employee_data.detect{|aa| aa.include?(username)})
    employee_data[username_index][1]
  end

end
