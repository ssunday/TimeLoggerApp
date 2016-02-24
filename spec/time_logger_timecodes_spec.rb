require "time_logger_timecodes"

include TimeLoggerTimecodes

describe TimeLoggerTimecodes do


  describe "#billable_work?" do

    it "is false when time code is not Billable Work" do
      timecode = "Non-billable work"
      expect(billable_work?(timecode)).to eql false
    end

    it "is false when time code is not Billable Work" do
      timecode = "PTO"
      expect(billable_work?(timecode)).to eql false
    end

    it "is true when time code is Billable Work" do
      timecode = "Billable Work"
      expect(billable_work?(timecode)).to eql true
    end

  end

  it "available timecodes constant returns array" do
    expect(AVAILABLE_TIMECODES).to be_an_instance_of(Array)
  end

end
