class TimeLoggerMenuOption

  def initialize
    @option_description = "Default Option."
  end

  def execute(logger, io, username)
    false
  end

  def to_s
     @option_description
  end

end
