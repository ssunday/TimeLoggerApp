$LOAD_PATH.unshift(File.dirname(__FILE__))

require "time_logger_menu_option"
require "time_logger_timecodes"

class TimeLoggerLogHoursMenuOption < TimeLoggerMenuOption

  include TimeLoggerTimecodes

  def initialize
    @option_description = "Enter Hours"
  end

  def execute(data_logging, io, username)
    date_and_time = io.specify_date_and_time
    hours = io.get_hours_worked
    timecode = io.select_timecode(AVAILABLE_TIMECODES)
    client = billable_work?(timecode) ? io.select_client(data_logging.get_client_names) : nil
    data_logging.log_employee_hours(username: username, date_and_time: date_and_time, hours: hours, timecode: timecode, client: client)
  end

end
