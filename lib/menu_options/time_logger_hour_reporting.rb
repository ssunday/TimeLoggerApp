module TimeLoggerHourReporting

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
