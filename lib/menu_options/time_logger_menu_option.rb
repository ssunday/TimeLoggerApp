
class TimeLoggerMenuOption

  AVAILABLE_TIMECODES = ["Billable Work",
                        "Non-billable work",
                        "PTO"]

  def initialize
    @option_description = "Default Option."
  end

  def execute(logger, io, username)
    false
  end

  def to_s
     @option_description
  end

  def timecodes
    AVAILABLE_TIMECODES
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

  def specific_attribute_valid?(specific_attribute, all_attributes)
    specific_attribute != nil &&
    all_attributes.index(all_attributes.detect{|aa| aa.include?(specific_attribute)}) != nil
  end

end
