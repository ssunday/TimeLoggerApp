require "csv"
class TimeLoggerDataLogging

  def initialize(filename = "timelog.csv")
    @time_log_file_name = filename
  end

  def log_time(date, hours, timecode)
    CSV.open(@time_log_file_name, "ab") do |csv|
      csv << [date, hours, timecode]
    end
  end


  def clear_data
    CSV.open(@time_log_file_name, "wb") do |csv|
    end
  end

end
