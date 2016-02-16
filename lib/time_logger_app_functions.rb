

module TimeLoggerAppFunctions

  def authorize_user(username, employees)
    employees.each do |employee|
      if username.eql?(employee)
        return true
      end
    end
    false
  end

  def detailed_time_report(args = {})

  end

  def time_worked_by_specification(args = {})
    hours_collection = args[:hours_collection]
    hours_worked = args[:hours]
    specific_attribute = args[:specific_attribute]
    all_attributes = args[:all_attributes]
    for z in 0..all_attributes.length
      if specific_attribute.eql?(all_attributes[z])
        hours_collection[z] += hours_worked
      end
    end
  end

  def time_worked_per_employee(args = {})
    employee_hours = args[:client_hours]
    hours = args[:hours]
    employee = args[:clients]
    employee_names = args[:client]
    for z in 0..employee_names.length
      if employee.eql?(employee_names[z])
        employee_hours[j] += hours
      end
    end
  end

  def collect_project_and_client_total_hours(args = {})
    month = args[:month]
    year = args[:year]
    project_hours = args[:project_hours]
    client_hours = args[:client_hours]
    hours = args[:hours]
    client = args[:client]
    timecode = args[:timecode]
    client_names = args[:client_names]
    timecodes = args[:timecodes]
    if month == Date.today.month && year == Date.today.year
      time_worked_by_specification(hours_collection: project_hours, hours: hours, specific_attribute: timecode, all_attributes: timecodes)
      if client != nil
        time_worked_by_specification(hours_collection: client_hours, hours: hours, all_attributes: client_names, specific_attribute: client)
      end
    end
  end

  def collect_employee_total_hours(args = {})
    month = args[:month]
    year = args[:year]
    hours = args[:hours]
    employee_hours = args[:employee_hours]
    employee_names = args[:employee_names]
    employee_name = args[:employee_name]
    if month == Date.today.month && year == Date.today.year
      time_worked_by_specification(hours_collection: employee_hours, hours: hours, \
                                  specific_attribute: employee_name, all_attributes: employee_names)
    end
  end

end
