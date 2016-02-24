module TimeLoggerTimecodes

  AVAILABLE_TIMECODES = ["Billable Work",
                        "Non-billable work",
                        "PTO"]

  def billable_work?(timecode)
    timecode.eql?("Billable Work")
  end
  
end
