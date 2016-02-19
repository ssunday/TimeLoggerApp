class TimeLoggerAdmin

  def authorize_user(username, employee_names)
    employee_names.include?(username)
  end

  def admin_from_authorized_username?(username, employee_data)
    username_index = employee_data.index(employee_data.detect{|aa| aa.include?(username)})
    employee_data[username_index][1].eql?("true")
  end

end
