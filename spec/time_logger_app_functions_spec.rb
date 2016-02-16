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


end
