module TimeLoggerAppFunctions

  AVAILABLE_TIMECODES = ["Billable Work",
                        "Non-billable work",
                        "PTO"]

  MENU_EMPLOYEE = ["Enter Hours",
                  "Report Current Month's Time",
                  "Log out"]

  MENU_ADMIN = ["Enter Hours",
                "Report Current Month's Time",
                "All Employee's Report",
                "Add Employee" ,
                "Add Client",
                "Log out"]

  def time_worked_by_specification(args = {})
    hours_collection = args[:hours_collection]
    hours_worked = args[:hours]
    specific_attribute = args[:specific_attribute]
    all_attributes = args[:all_attributes]
    for z in 0..all_attributes.length
      if specific_attribute != nil && specific_attribute.eql?(all_attributes[z])
        hours_collection[z] += hours_worked
      end
    end
  end

  def get_list_of_dates_worked_in_month(data, username)
    date_list = []
    data.each do |data_set|
      if data_set[0].eql?(username)
        parsed_date = Date.parse(data_set[1])
        if parsed_date.month == Date.today.month && parsed_date.year == Date.today.year
          date_list << data_set[1]
        end
      end
    end
    date_list = date_list.map {|s| Date.parse(s)}
    date_list = date_list.sort
    date_list = date_list.map {|date| date.strftime('%-d/%-m/%Y')}
    date_list.uniq
  end

  def collect_hours_in_month(args = {})
    if args[:month] == Date.today.month && args[:year] == Date.today.year
      time_worked_by_specification(hours_collection: args[:hours_collection],
                hours: args[:hours], all_attributes: args[:all_attributes], specific_attribute: args[:specific_attribute])
    end
  end

  def get_timecode(timecode_selection)
    timecode = AVAILABLE_TIMECODES[timecode_selection]
  end

  def billable_work?(timecode)
    timecode.eql?("Billable Work")
  end

  def get_employee_time_to_report(args = {})
    args[:time_log].each do |row|
      if row[0].eql?(args[:username])
        date = row[1].split('/')
        month = date[1].to_i
        year = date[2].to_i
        hours = row[2].to_i
        employee_name = row[0]
        client = row[4]
        timecode = row[3]
        time_worked_by_specification(hours: hours, specific_attribute: row[1],
                          all_attributes: args[:date_list], hours_collection: args[:hours_worked_in_month])
        collect_hours_in_month(hours_collection: args[:client_hours], all_attributes: args[:client_names], specific_attribute: client,
                                month: month, year: year, hours: hours)
        collect_hours_in_month(hours_collection: args[:project_hours], all_attributes: AVAILABLE_TIMECODES, specific_attribute: timecode,
                                month: month, year: year, hours: hours)
      end
    end
  end

  def get_admin_time_to_report(args = {})
    args[:time_log].each do |row|
      date = row[1].split('/')
      month = date[1].to_i
      year = date[2].to_i
      hours = row[2].to_i
      employee_name = row[0]
      client = row[4]
      timecode = row[3]
      collect_hours_in_month(hours_collection: args[:employee_hours], all_attributes: args[:employee_names], specific_attribute: employee_name,
                              month: month, year: year, hours: hours)
      collect_hours_in_month(hours_collection: args[:client_hours], all_attributes: args[:client_names], specific_attribute: client,
                              month: month, year: year, hours: hours)
      collect_hours_in_month(hours_collection: args[:project_hours], all_attributes: AVAILABLE_TIMECODES, specific_attribute: timecode,
                              month: month, year: year, hours: hours)
    end
  end
end
