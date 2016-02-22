require 'date'

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

  def get_timecode(timecode_selection)
    timecode = AVAILABLE_TIMECODES[timecode_selection]
  end

  def billable_work?(timecode)
    timecode.eql?("Billable Work")
  end

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

  private

  def specific_attribute_valid?(specific_attribute, all_attributes)
    specific_attribute != nil &&
    all_attributes.index(all_attributes.detect{|aa| aa.include?(specific_attribute)}) != nil
  end

end
