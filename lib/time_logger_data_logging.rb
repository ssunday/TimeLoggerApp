require "csv"

class TimeLoggerDataLogging

  def initialize(filename = "files/timelog.csv")
    @time_log_file_name = filename
  end

  def log_time(args = {})
    username = args[:username]
    date = args[:date]
    hours = args[:hours]
    timecode = args[:timecode]
    client = args.fetch(:client, nil)
    CSV.open(@time_log_file_name, "ab") do |csv|
      csv << [username, date, hours, timecode, client]
    end
  end

  def read_data
    CSV.read(@time_log_file_name)
  end


  def clear_data
    CSV.open(@time_log_file_name, "w") do |csv|
    end
  end

end
