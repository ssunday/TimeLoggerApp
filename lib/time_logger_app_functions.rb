

module TimeLoggerAppFunctions

  def authorize_user(username, employees)
    employees.each do |employee|
      if username.eql?(employee)
        return true
      end
    end
    false
  end

  def user_is_admin(username, employee_and_admin)
    employee_and_admin.each do |name_and_admin|
      if username.eql?(name_and_admin[0])
        return name_and_admin[1]
      end
    end
  end

  # def time_worked_per_project_type(args ={})
  #   username = args[:username]
  #   date_collection = args[:date]
  #   timecodes = args[:timecodes]
  # end

end
