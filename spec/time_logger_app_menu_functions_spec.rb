require "time_logger_app_menu_functions"

include TimeLoggerAppMenuFunctions

describe TimeLoggerAppMenuFunctions do

  before do
    @employee_list = ["jjam", "bbob", "zwane"]
    @employee_and_admin_list = [["jjam", true], ["bbob", false] , ["zwane", false]]
    @client_names = ["Foogle", "Bar"]
  end

  describe "#collect_hours_worked_by_specification" do

    it "returns a list of hours worked that match up by index location to a client names listing" do
      names_and_hours = [["Foogle", 10], ["Bar", 3], ["Bar", 1]]
      hours_worked = collect_hours_worked_by_specification(@client_names, names_and_hours)
      expect(hours_worked).to eql [10,4]
    end

    it "returns a list of hours worked that match up by index location to timecode" do
      time_codes_and_hours = [["PTO", 10], ["Billable Work", 3], ["Non-billable work", 1]]
      hours_worked = collect_hours_worked_by_specification(AVAILABLE_TIMECODES, time_codes_and_hours)
      expect(hours_worked).to eql [3,1,10]
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

  describe "#assign_menu" do

    it "assigns admin menu for true is_admin value" do
      is_admin = true
      expect(assign_menu(is_admin)).to eql MENU_ADMIN
    end

    it "assigns employee menu for false is_admin value" do
      is_admin = false
      expect(assign_menu(is_admin)).to eql MENU_EMPLOYEE
    end
  end

end
