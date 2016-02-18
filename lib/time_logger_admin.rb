class TimeLoggerAdmin

  def authorize_user(username, employee_names)
    employee_names.include?(username)
  end

  def admin_from_username?(username, employee_data)
    employee_data.each do |set|
      if username.eql?(set[0])
        return set[1].eql?("true")
      end
    end
  end

end
