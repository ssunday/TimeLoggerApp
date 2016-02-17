require "time_logger_app_functions"

include TimeLoggerAppFunctions

describe TimeLoggerAppFunctions do

  before do
    @timecodes = ["Billable Work", "Non-billable work", "PTO"]
    @employee_list = ["jjam", "bbob", "zwane"]
    @employee_and_admin_list = [["jjam", true], ["bbob", false] , ["zwane", false]]
    @client_names = ["Foogle", "Bar"]
  end

  describe "#authorize_user" do

    it "returns true for user that is in system" do
      user = "jjam"
      expect(authorize_user(user, @employee_list)).to eql true
    end

    it "returns false for user that is not in system" do
      user = "failure"
      expect(authorize_user(user, @employee_list)).to eql false
    end

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

end
