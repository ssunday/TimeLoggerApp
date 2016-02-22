require 'date'

#This can easily become a dumping ground for any function
#Is there any cohesion between the functions here?
#What is a better name?
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

  def assign_menu(is_admin)
    is_admin ? MENU_ADMIN : MENU_EMPLOYEE
  end

  def time_worked_by_specification(args = {})
    specific_attribute = args[:specific_attribute]
    all_attributes = args[:all_attributes]
    if specific_attribute_valid?(specific_attribute, all_attributes)
      specific_attribute_index = all_attributes.index(all_attributes.detect{|aa| aa.include?(specific_attribute)})
      args[:hours_collection][specific_attribute_index] += args[:hours]
    end
  end

  def get_list_of_dates_worked_in_month(data, username)
    dates = []
    data.each do |time_log_data|
      if time_log_data[0].eql?(username)
        date = DateTime.parse(time_log_data[1])
        if date_in_current_month(date.month, date.year)
          dates << time_log_data[1]
        end
      end
    end
    dates = dates.map {|s| DateTime.parse(s)}
    dates = dates.sort
    dates = dates.map {|date| date.strftime('%-d/%-m/%Y')}
    dates.uniq
  end

  def collect_hours_in_month(args = {})
    if date_in_current_month(args[:month], args[:year])
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

  #The knowledge of which fields are in which row should be encapsulated
  #in the data logging class.  If you changed the column layout, which
  #files would have to change?
  def get_employee_time_to_report(args = {})
    args[:time_log].each do |row|
      if row[0].eql?(args[:username])
        date = DateTime.parse(row[1])
        date_plain = date.strftime('%-d/%-m/%Y')
        hours = row[2].to_i
        employee_name = row[0]
        client = row[4]
        timecode = row[3]
        time_worked_by_specification(hours: hours, specific_attribute: date_plain,
                          all_attributes: args[:date_list], hours_collection: args[:hours_worked_in_month])
        collect_hours_in_month(hours_collection: args[:client_hours], all_attributes: args[:client_names], specific_attribute: client,
                                month: date.month, year: date.year, hours: hours)
        collect_hours_in_month(hours_collection: args[:project_hours], all_attributes: AVAILABLE_TIMECODES, specific_attribute: timecode,
                                month: date.month, year: date.year, hours: hours)
      end
    end
  end

  #it's not clear what the inputs and outputs to this function are
  def get_admin_time_to_report(args = {})
    args[:time_log].each do |row|
      date = DateTime.parse(row[1])
      hours = row[2].to_i
      employee_name = row[0]
      client = row[4]
      timecode = row[3]
      collect_hours_in_month(hours_collection: args[:employee_hours], all_attributes: args[:employee_names], specific_attribute: employee_name,
                              month: date.month, year: date.year, hours: hours)
      collect_hours_in_month(hours_collection: args[:client_hours], all_attributes: args[:client_names], specific_attribute: client,
                              month: date.month, year: date.year, hours: hours)
      collect_hours_in_month(hours_collection: args[:project_hours], all_attributes: AVAILABLE_TIMECODES, specific_attribute: timecode,
                              month: date.month, year: date.year, hours: hours)
    end
  end

  private

  def specific_attribute_valid?(specific_attribute, all_attributes)
    specific_attribute != nil &&
    all_attributes.index(all_attributes.detect{|aa| aa.include?(specific_attribute)}) != nil
  end

  def date_in_current_month(month, year)
    month == Date.today.month && year == Date.today.year
  end

end
