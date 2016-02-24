require "time_logger_menu_option"

class TimeLoggerEmployeeReportTimeOption < TimeLoggerAppMenuOption

  def execute(data_logging, io, username)
    date_list = data_logging.get_list_of_dates_worked_in_month_by_user(username)
    project_hours = collect_hours_worked_by_specification(timecodes,
                        data_logging.time_codes_and_hours_for_current_month_and_username(username))
    client_hours = collect_hours_worked_by_specification(data_logging.client_names,
                                        data_logging.client_names_and_hours_for_current_month_and_username(username))
    hours_worked_in_month = collect_hours_worked_by_specification(date_list,
                                      data_logging.dates_and_hours_for_current_month_and_username(username))
    io.display_hours_worked_per_project(timecodes, project_hours)
    io.display_hours_worked_per_client(data_logging.client_names, client_hours)
    io.display_hours_worked_in_month(date_list, hours_worked_in_month)
  end

  def to_s
    "Your Current Month Report"
  end

  # private
  #
  # def collect_hours_worked_by_specification(all_attributes, attributes_and_hours)
  #   hours_worked = Array.new(all_attributes.length, 0)
  #   attributes_and_hours.each do |specific_attribute, hours|
  #     if specific_attribute_valid?(specific_attribute, all_attributes)
  #       specific_attribute_index = all_attributes.index(all_attributes.detect{|aa| aa.include?(specific_attribute)})
  #       hours_worked[specific_attribute_index] += hours
  #     end
  #   end
  #   hours_worked
  # end
  #
  # def specific_attribute_valid?(specific_attribute, all_attributes)
  #   specific_attribute != nil &&
  #   all_attributes.index(all_attributes.detect{|aa| aa.include?(specific_attribute)}) != nil
  # end

end
