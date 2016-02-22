require "time_logger_app_functions"

include TimeLoggerAppFunctions

describe TimeLoggerAppFunctions do

  before do
    @employee_list = ["jjam", "bbob", "zwane"]
    @employee_and_admin_list = [["jjam", true], ["bbob", false] , ["zwane", false]]
    @client_names = ["Foogle", "Bar"]
  end

  describe "#time_worked_per_specification" do

    it "Correctly adds project hours with project type" do
      timecode = "PTO"
      hours = 10
      project_hours = Array.new(AVAILABLE_TIMECODES.length, 0)
      time_worked_by_specification(hours_collection: project_hours, hours: hours, specific_attribute: timecode, all_attributes: AVAILABLE_TIMECODES)
      expect(project_hours).to eql [0,0,hours]
    end

    it "Correctly adds project hours with client type" do
      client = "Foogle"
      hours = 11
      client_hours = Array.new(@client_names.length, 0)
      time_worked_by_specification(hours_collection: client_hours, hours: hours, specific_attribute: client, all_attributes: @client_names)
      expect(client_hours).to eql [hours, 0]
    end

  end

  describe "#collect_hours_in_month" do
    it "will only collect hours if given month and year is current" do
      month = Date.today.month
      year = Date.today.year
      client = "Foogle"
      hours = 11
      client_hours = Array.new(@client_names.length, 0)

      collect_hours_in_month(hours_collection: client_hours, all_attributes: @client_names, specific_attribute: client, \
                              month: month, year: year, hours: hours)

      expect(client_hours).to eql [hours, 0]
    end

    it "will not collect hours if given month and year is not current" do
      month = Date.today.prev_month
      year = Date.today.prev_year
      client = "Foogle"
      hours = 11
      client_hours = Array.new(@client_names.length, 0)

      collect_hours_in_month(hours_collection: client_hours, all_attributes: @client_names, specific_attribute: client, \
                              month: month, year: year, hours: hours)

      expect(client_hours).to eql [0, 0]
    end
  end

  describe "#get_list_of_dates_worked_in_month" do

    it "returns a sorted list of dates the employee worked" do
      active_employee = @employee_list[0]
      non_active = @employee_list[1]
      today = Date.today.strftime('%-d/%-m/%Y')
      yesterday = Date.today.prev_day.strftime('%-d/%-m/%Y')
      tomorrow = Date.today.next.strftime('%-d/%-m/%Y')
      previous_year_day = Date.new(1999,10,15).strftime('%-d/%-m/%Y')
      example_date_set = [[active_employee, today],
                          [active_employee, yesterday],
                          [active_employee, previous_year_day],
                          [non_active, tomorrow],
                          [non_active, previous_year_day]]
      expect(get_list_of_dates_worked_in_month(example_date_set, active_employee)).to eql [yesterday, today]
    end

  end

  describe "#billable_work?" do

    it "is false when time code is not Billable Work" do
      timecode = AVAILABLE_TIMECODES[1]
      expect(billable_work?(timecode)).to eql false
    end

    it "is false when time code is not Billable Work" do
      timecode = AVAILABLE_TIMECODES[2]
      expect(billable_work?(timecode)).to eql false
    end

    it "is true when time code is Billable Work" do
      timecode = AVAILABLE_TIMECODES[0]
      expect(billable_work?(timecode)).to eql true
    end

  end

  describe "#get_timecode" do

    it "returns 1st available timecodes for 0" do
      expected_value = AVAILABLE_TIMECODES[0]
      expect(get_timecode(0)).to eql expected_value
    end

    it "returns 2nd available timecodes for 1" do
      expected_value = AVAILABLE_TIMECODES[1]
      expect(get_timecode(1)).to eql expected_value
    end

    it "returns 3rd available timecodes for 2" do
      expected_value = AVAILABLE_TIMECODES[2]
      expect(get_timecode(2)).to eql expected_value
    end

  end

  it "#get_admin_time_to_report assigns correct values to designated lists" do
    today = Date.today.strftime('%-d/%-m/%Y')
    hours1 = 10
    hours2 = 5
    hours3 = 3
    time_log = [[@employee_list[0], today, hours1, AVAILABLE_TIMECODES[1], nil],
                [@employee_list[1], today, hours2, AVAILABLE_TIMECODES[0], @client_names[0]],
                [@employee_list[2], today, hours3, AVAILABLE_TIMECODES[2], nil]]
    project_hours = Array.new(AVAILABLE_TIMECODES.length, 0)
    client_hours = Array.new(@client_names.length,0)
    employee_hours = Array.new(@employee_list.length,0)
    get_admin_time_to_report(time_log: time_log, project_hours: project_hours,
                      client_hours: client_hours, employee_hours: employee_hours,
                      client_names: @client_names, employee_names: @employee_list)
    #modifing input params is not typically done in ruby. Return them instead
    expect(client_hours).to eql [hours2,0]
    expect(project_hours).to eql [hours2,hours1,hours3]
    expect(employee_hours).to eql [hours1,hours2,hours3]
  end

  it "#get_employee_time_to_report assigns correct values to designated lists" do
    today = Date.today.strftime('%-d/%-m/%Y')
    hours1 = 10
    hours2 = 5
    hours3 = 3
    username = @employee_list[0]
    time_log = [[@employee_list[0], today, hours1, AVAILABLE_TIMECODES[1], nil],
                [@employee_list[0], today, hours2, AVAILABLE_TIMECODES[2], nil],
                [@employee_list[1], today, hours2, AVAILABLE_TIMECODES[0], @client_names[0]],
                [@employee_list[2], today, hours3, AVAILABLE_TIMECODES[2], nil]]
    project_hours = Array.new(AVAILABLE_TIMECODES.length, 0)
    client_hours = Array.new(@client_names.length, 0)
    date_list = get_list_of_dates_worked_in_month(time_log, username)
    hours_worked_in_month = Array.new(date_list.length, 0)
    get_employee_time_to_report(time_log: time_log, username: username, project_hours: project_hours,
                      client_hours: client_hours, hours_worked_in_month: hours_worked_in_month,
                      client_names: @client_names, date_list: date_list)
    expect(client_hours).to eql [0,0]
    expect(project_hours).to eql [0,hours1,hours2]
    expect(hours_worked_in_month).to eql [hours1+hours2]
  end

  describe "#assign_menu" do

    it "assigns admin menu for true is_admin value" do
      is_admin = true
      expect(assign_menu(is_admin)).to eql MENU_ADMIN
    end

    it "assigns employee menu for false is_admin value" do
      is_admin = false
      expect(assign_menu(is_admin)).to eql MENU_EMPLOYEE
    end
  end

end
