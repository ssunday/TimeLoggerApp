class TimeLoggerLogoutOption

  def execute(data_logging, io, username, timecodes)
    io.end_message
    false
  end

  def to_s
    "Log out"
  end

end
