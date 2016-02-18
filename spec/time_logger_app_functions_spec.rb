require "time_logger_app_functions"

include TimeLoggerAppFunctions

describe TimeLoggerAppFunctions do

  before do
    @timecodes = ["Billable Work", "Non-billable work", "PTO"]
    @employee_list = ["jjam", "bbob", "zwane"]
    @employee_and_admin_list = [["jjam", true], ["bbob", false] , ["zwane", false]]
    @client_names = ["Foogle", "Bar"]
  end

  describe "#time_worked_per_specification" do

    it "Correctly adds project hours with project type" do
      timecode = "PTO"
      hours = 10
      project_hours = Array.new(@timecodes.length, 0)
      time_worked_by_specification(hours_collection: project_hours, hours: hours, specific_attribute: timecode, all_attributes: @timecodes)
      expect(project_hours).to eql [0,0,hours]
    end

    it "Correctly adds project hours with client type" do
      client = "Foogle"
      hours = 11
      client_hours = Array.new(@client_names.length, 0)
      time_worked_by_specification(hours_collection: client_hours, hours: hours, specific_attribute: client, all_attributes: @client_names)
      expect(client_hours).to eql [hours, 0]
    end

  end

  describe "#collect_hours_in_month" do
    it "will only collect hours if given month and year is current" do
      month = Date.today.month
      year = Date.today.year
      client = "Foogle"
      hours = 11
      client_hours = Array.new(@client_names.length, 0)

      collect_hours_in_month(hours_collection: client_hours, all_attributes: @client_names, specific_attribute: client, \
                              month: month, year: year, hours: hours)

      expect(client_hours).to eql [hours, 0]
    end

    it "will not collect hours if given month and year is not current" do
      month = Date.today.prev_month
      year = Date.today.prev_year
      client = "Foogle"
      hours = 11
      client_hours = Array.new(@client_names.length, 0)

      collect_hours_in_month(hours_collection: client_hours, all_attributes: @client_names, specific_attribute: client, \
                              month: month, year: year, hours: hours)

      expect(client_hours).to eql [0, 0]
    end
  end

  describe "#get_list_of_dates_worked_in_month" do

    it "returns a sorted list of dates the employee worked" do
      active_employee = @employee_list[0]
      non_active = @employee_list[1]
      today = Date.today.strftime('%-d/%-m/%Y')
      yesterday = Date.today.prev_day.strftime('%-d/%-m/%Y')
      tomorrow = Date.today.next.strftime('%-d/%-m/%Y')
      previous_year_day = Date.new(1999,10,15).strftime('%-d/%-m/%Y')
      example_date_set = [[active_employee, today],
                          [active_employee, yesterday],
                          [active_employee, previous_year_day],
                          [non_active, tomorrow],
                          [non_active, previous_year_day]]
      expect(get_list_of_dates_worked_in_month(example_date_set, active_employee)).to eql [yesterday, today]
    end

  end

  describe "#billable_work?" do

    it "is false when time code is not Billable Work" do
      timecode = AVAILABLE_TIMECODES[1]
      expect(billable_work?(timecode)).to eql false
    end

    it "is false when time code is not Billable Work" do
      timecode = AVAILABLE_TIMECODES[2]
      expect(billable_work?(timecode)).to eql false
    end

    it "is true when time code is Billable Work" do
      timecode = AVAILABLE_TIMECODES[0]
      expect(billable_work?(timecode)).to eql true
    end

  end

  describe "#get_timecode" do

    it "returns 1st available timecodes for 0" do
      expected_value = AVAILABLE_TIMECODES[0]
      expect(get_timecode(0)).to eql expected_value
    end

    it "returns 2nd available timecodes for 1" do
      expected_value = AVAILABLE_TIMECODES[1]
      expect(get_timecode(1)).to eql expected_value
    end

    it "returns 3rd available timecodes for 2" do
      expected_value = AVAILABLE_TIMECODES[2]
      expect(get_timecode(2)).to eql expected_value
    end

  end

end
