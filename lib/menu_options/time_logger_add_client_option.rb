class TimeLoggerAddClientOption

  def execute(data_logging, io, username, timecodes)
    client_name = io.get_client_name(data_logging.client_names)
    data_logging.add_client(client_name)
  end

  def to_s
    "Add Client"
  end

end
