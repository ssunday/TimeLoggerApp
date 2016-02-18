require "time_logger_admin"

describe TimeLoggerAdmin do

  before do
    @admin = TimeLoggerAdmin.new
  end

  it "#admin_from_username? verifies if user is admin or not" do
    employee = ["sasunday", "true"]
    expect(@admin.admin_from_username?(employee[0], [employee])).to eql true
  end

  describe "#authorize_user" do

    it "returns true for user that is in system" do
      employee = ["jjam", "false"]
      user = "jjam"
      expect(@admin.authorize_user(user, [employee[0]])).to eql true
    end

    it "returns false for user that is not in system" do
      user = "failure"
      expect(@admin.authorize_user(user, [])).to eql false
    end

  end

end
