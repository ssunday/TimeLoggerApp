require "csv"

class TimeLoggerDataLogging

  def initialize(filenames = {})
    @time_log_file_name = filenames[:time_log_file_name]
    @employees_file_name = filenames[:employees_file_name]
    @clients_file_name = filenames[:clients_file_name]
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
