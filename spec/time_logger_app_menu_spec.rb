require "time_logger_app_menu"
require "time_logger_mock_io"
require "time_logger_mock_data_interface"

describe TimeLoggerMenu do

  before do
    @menu = TimeLoggerMenu.new(TimeLoggerMockIO.new, TimeLoggerMockDataInterface.new)
  end

  describe "#assign_menu_based_on_whether_employee_is_admin" do

    it "returns employee menu when they are not admin" do
      admin = false
      expect(@menu.assign_menu_based_on_whether_employee_is_admin(admin)).to eql TimeLoggerMenu::MENU_OPTIONS_EMPLOYEE
    end

    it "returns admin menu when they are admin" do
      admin = true
      expect(@menu.assign_menu_based_on_whether_employee_is_admin(admin)).to eql TimeLoggerMenu::MENU_OPTIONS_ADMIN
    end

  end

  describe "#options" do

    it "returns an array for admin" do
      admin = true
      @menu.assign_menu_based_on_whether_employee_is_admin(admin)
      expect(@menu.options).to be_an_instance_of(Array)
    end

    it "returns an array for employee" do
      admin = false
      @menu.assign_menu_based_on_whether_employee_is_admin(admin)
      expect(@menu.options).to be_an_instance_of(Array)
    end

  end

end
