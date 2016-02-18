require "time_logger_admin"

describe TimeLoggerAdmin do

  before do
    @admin = TimeLoggerAdmin.new
  end

  describe "#admin_from_username?" do

    it "returns true if user is admin" do
      employee = ["sasunday", "true"]
      expect(@admin.admin_from_username?(employee[0], [employee])).to eql true
    end

    it "returns false if user is not admin" do
      employee = ["sasunday", "false"]
      expect(@admin.admin_from_username?(employee[0], [employee])).to eql false
    end

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
