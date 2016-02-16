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

  describe "#time_worked_per_project_type" do

    it "Correctly adds project hours with specified type" do
      timecode = "PTO"
      hours = 10
      project_hours = Array.new(@timecodes.length, 0)
      time_worked_per_project_type(project_hours: project_hours, hours: hours, timecode: timecode, timecodes: @timecodes)
      expect(project_hours).to eql [0,0,hours]
    end

  end

  describe "#time_worked_per_client_type" do

    it "Correctly adds client hours with specified client" do
      client = "Foogle"
      hours = 15
      client_hours = Array.new(@client_names.length, 0)
      time_worked_per_client(client_hours: client_hours, hours: hours, client: client, clients: @client_names)
      expect(client_hours).to eql [hours,0]
    end

  end

end
