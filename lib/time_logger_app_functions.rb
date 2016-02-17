module TimeLoggerAppFunctions

  def authorize_user(username, employees)
    employees.each do |employee|
      if username.eql?(employee)
        return true
      end
    end
    false
  end

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
    month = args[:month]
    year = args[:year]
    if month == Date.today.month && year == Date.today.year
      time_worked_by_specification(hours_collection: args[:hours_collection], \
                hours: args[:hours], all_attributes: args[:all_attributes], specific_attribute: args[:specific_attribute])
    end
  end

end
