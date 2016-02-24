
class TimeLoggerLogHoursMenuOption

  def execute(data_logging, io, username, timecodes)
    date_and_time = io.specify_date_and_time
    hours = io.get_hours_worked
    timecode = io.select_timecode(timecodes)
    client = billable_work?(timecode) ? io.select_client(data_logging.client_names) : nil
    data_logging.log_time([username, date_and_time, hours, timecode, client])
  end

  def to_s
    "Enter Hours"
  end

  def billable_work?(timecode)
    timecode.eql?("Billable Work")
  end

end
