

module TimeLoggerAppFunctions

  def authorize_user(username, employees)
    employees.each do |employee|
      if username.eql?(employee)
        return true
      end
    end
    false
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
