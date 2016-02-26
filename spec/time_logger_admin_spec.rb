require "time_logger_admin"

include TimeLoggerAdmin

describe TimeLoggerAdmin do

  describe "#username_is_registered_employee?" do

    it "returns true for user that is in system" do
      employee = ["jjam", false]
      user = "jjam"
      expect(username_is_registered_employee?(user, [employee[0]])).to eql true
    end

    it "returns false for user that is not in system" do
      user = "failure"
      expect(username_is_registered_employee?(user, [])).to eql false
    end

  end

  describe "#registered_employee_is_admin?" do

    it "returns true if user is admin" do
      employee = ["sasunday", true]
      expect(registered_employee_is_admin?(employee[0], [employee])).to eql true
    end

    it "returns false if user is not admin" do
      employee = ["sasunday", false]
      expect(registered_employee_is_admin?(employee[0], [employee])).to eql false
    end

  end

end
