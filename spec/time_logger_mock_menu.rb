class TimeLoggerMockMenu

  MENU_OPTIONS_EMPLOYEE = {1 => "Option 1",
                  2 => "Option 2",
                  3 => false}


  MENU_OPTIONS_ADMIN = {
                  1 => "Option 1",
                  2 => "Option 2",
                  3 => "Option 3",
                  4 => "Option 4",
                  5 => "Option 5",
                  6 => false}

  def initialize(logger, io)
    @data_logger = logger
    @io = io
  end

  def assign_menu_based_on_whether_employee_is_admin(is_user_admin)
    @active_menu = is_user_admin ? MENU_OPTIONS_ADMIN : MENU_OPTIONS_EMPLOYEE
  end

  def do_menu_option(option, username)
    if @active_menu[option] == nil
      true
    else
      @active_menu[option]
    end
  end

  def options
    @active_menu.values
  end

end
