

module TimeLoggerAppFunctions

  def authorize_user(username, employees)
    employees.each do |employee|
      if username.eql?(employee)
        return true
      end
    end
    false
  end

  # def detailed_time_report(args = {})
  #
  # end

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
      time_worked_per_project_type(project_hours: project_hours, hours: hours, timecodes: timecodes, timecode: timecode)
      if client != nil
        time_worked_per_client(client_hours: client_hours, hours: hours, clients: client_names, client: client)
      end
    end
  end

  def time_worked_per_client(args = {})
    client_hours = args[:client_hours]
    hours = args[:hours]
    clients = args[:clients]
    client = args[:client]
    for j in 0..clients.length
      if client.eql?(clients[j])
        client_hours[j] += hours
      end
    end
  end

  def time_worked_per_project_type(args ={})
    project_hours = args[:project_hours]
    hours = args[:hours]
    timecode = args[:timecode]
    timecodes = args[:timecodes]
    for i in 0..timecodes.length
      if timecode.eql?(timecodes[i])
        project_hours[i] += hours
      end
    end
  end

end
