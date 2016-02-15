require "time_logger_app_functions"

include TimeLoggerAppFunctions

describe TimeLoggerAppFunctions do

  before do
    @employee_list = ["jjam", "bbob", "zwane"]
    @employee_and_admin_list = [["jjam", true], ["bbob", false] , ["zwane", false]]
  end

  describe "#authorize_user" do

    it "returns true for user that is in system" do
      user = "jjam"
      expect(authorize_user(user, @employee_list)).to eql true
    end

    it "returns false for user that is not in system" do
      user = "failure"
      expect(authorize_user(user, @employee_list)).to eql false
    end

  end

  describe "#user_is_admin" do

    it "returns true for user that is admin" do
      user = "jjam"
      expect(user_is_admin(user, @employee_and_admin_list)).to eql true
    end

    it "returns false for user that is not admin" do
      user = "bbob"
      expect(user_is_admin(user, @employee_and_admin_list)).to eql false
    end
  end

end
