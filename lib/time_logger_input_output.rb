module TimeLoggerInputOutput

  MENU_EMPLOYEE = ["Enter Hours", "Report Current Month's Time"]

  MENU_ADMIN = ["Enter Hours", "Report Current Month's Time", "Add Employee" , "Add Client"]

  def display_menu(is_admin)
    if is_admin
      iterate_through_list_with_numbers(MENU_ADMIN)
    else
      iterate_through_list_with_numbers(MENU_EMPLOYEE)
    end
  end

  def welcome_message
    puts "Welcome to the Time Logger App. Please input your username."
  end

  def input_username
    gets.chomp
  end

  def specify_date_message
    puts "Input date you wish to add hours worked for in day/month/year format."
  end

  def bad_date_message
    puts "Sorry that date is invalid."
  end

  def specify_date
    date = gets.chomp
  end

  def hours_worked_message
    puts "Hours Worked:"
  end

  def hours_worked
    gets.chomp.to_i
  end

  def timecode_message(available_timecodes)
    puts "Choose one of the following time codes by selecting the number:"
    iterate_through_list_with_numbers(available_timecodes)
  end

  def select_client_message(clients)
    puts "Please select client :"
    iterate_through_list_with_numbers(clients)
  end

  def select_option
    option = gets.chomp
    if option =~ /\A\d+\z/ ? false : true
      return nil
    else
      return option.to_i
    end
  end

  private

  def iterate_through_list_with_numbers(specified_list)
    for counter in 1..(specified_list.length)
      puts "#{counter}: #{specified_list[counter-1]}"
    end
  end

end
