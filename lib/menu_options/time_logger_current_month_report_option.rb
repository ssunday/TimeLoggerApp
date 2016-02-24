class TimeLoggerCurrentMonthReportOption

  def execute(data_logging, io, username, timecodes)
    project_hours = collect_hours_worked_by_specification(timecodes, data_logging.time_codes_and_hours_for_current_month)
    client_hours = collect_hours_worked_by_specification(data_logging.client_names, data_logging.client_names_and_hours_for_current_month)
    employee_hours = collect_hours_worked_by_specification(data_logging.employee_names, data_logging.employee_names_and_hours_for_current_month)
    io.display_hours_worked_per_project(timecodes, project_hours)
    io.display_hours_worked_per_client(data_logging.client_names, client_hours)
    io.display_hours_worked_by_employee(data_logging.employee_names, employee_hours)
  end

  def to_s
    "Current Month Report"
  end

  private

  def collect_hours_worked_by_specification(all_attributes, attributes_and_hours)
    hours_worked = Array.new(all_attributes.length, 0)
    attributes_and_hours.each do |specific_attribute, hours|
      if specific_attribute_valid?(specific_attribute, all_attributes)
        specific_attribute_index = all_attributes.index(all_attributes.detect{|aa| aa.include?(specific_attribute)})
        hours_worked[specific_attribute_index] += hours
      end
    end
    hours_worked
  end

  def specific_attribute_valid?(specific_attribute, all_attributes)
    specific_attribute != nil &&
    all_attributes.index(all_attributes.detect{|aa| aa.include?(specific_attribute)}) != nil
  end

end
