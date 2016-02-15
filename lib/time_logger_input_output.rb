module TimeLoggerInputOutput

  def display_menu(menu)
    iterate_through_list_with_numbers(menu)
  end

  def welcome_message
    puts "Welcome to the Time Logger App. Please input your username."
  end

  def end_message
    puts "You have been logged out."
  end

  def input_username
    gets.chomp
  end

  def bad_user_name
    puts "Sorry, but that username is not in our system."
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

  def select_option(menu_length)
    puts "Please select which option by choosing the number."
    option = gets.chomp
    while option =~ /\A\d+\z/ ? false : true || option < 1 || option > menu_length
      bad_option
      option = gets.chomp
    end
    option.to_i
  end

  def bad_option
    puts "That is an invalid option. Please try again."
  end

  private

  def iterate_through_list_with_numbers(specified_list)
    for counter in 1..(specified_list.length)
      puts "#{counter}: #{specified_list[counter-1]}"
    end
  end

end
