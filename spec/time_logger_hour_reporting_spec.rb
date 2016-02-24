require "menu_options/time_logger_hour_reporting"

include TimeLoggerHourReporting

describe TimeLoggerHourReporting do

  before do
    @client_names = ["Foogle", "Bar"]
    @timecodes = ["Billable Work", "Non-billable work", "PTO"]
  end

  describe "#collect_hours_worked_by_specification" do

    it "returns a list of hours worked that match up by index location to a client names listing" do
      names_and_hours = [["Foogle", 10], ["Bar", 3], ["Bar", 1]]
      hours_worked = collect_hours_worked_by_specification(@client_names, names_and_hours)
      expect(hours_worked).to eql [10,4]
    end

    it "returns a list of hours worked that match up by index location to timecode" do
      time_codes_and_hours = [["PTO", 10], ["Billable Work", 3], ["Non-billable work", 1]]
      hours_worked = collect_hours_worked_by_specification(@timecodes, time_codes_and_hours)
      expect(hours_worked).to eql [3,1,10]
    end

  end

end
