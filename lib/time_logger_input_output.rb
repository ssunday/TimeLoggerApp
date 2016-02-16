require 'date'
require 'time'

class TimeLoggerInputOutput

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

  def specify_date
    puts "Input date you wish to add hours worked for in day/month/year format. Example: 15/7/2012."
    inputted_date = gets.chomp
    date_collection = inputted_date.split('/')
    while Date.valid_date?(date_collection[2].to_i, date_collection[1].to_i, date_collection[0].to_i) == false
      puts "Sorry that date is invalid."
      inputted_date = gets.chomp
      date_collection = inputted_date.split('/')
    end
    date = Date.parse(inputted_date)
    while date >= Date.today
      puts "Sorry that date is in the future."
      inputted_date = gets.chomp
      date = Date.parse(inputted_date)
    end
    date = date.strftime('%-d/%-m/%Y')
    return date
  end

  def hours_worked
    puts "Enter Hours Worked:"
    hours = gets.chomp
    while hours =~ /\A\d+\z/ ? false : true
      puts "Please enter an integer."
      hours = gets.chomp
    end
    hours.to_i
  end

  def select_timecode(available_timecodes)
    puts "Choose one of the following time codes by selecting the number:"
    iterate_through_list_with_numbers(available_timecodes)
    select_option(available_timecodes.length-1)
  end

  def select_client(clients)
    puts "Please select client: "
    iterate_through_list_with_numbers(clients)
    select_option(clients.length-1)
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

  def get_employee_info
    puts "Please enter employee's username."
    username = gets.chomp
    puts "Please enter true if they are admin and false if they are not."
    is_admin = gets.chomp
    while is_admin != "true" &&  is_admin != "false"
      puts "Invalid option. Try again."
      is_admin = gets.chomp
    end
    [username, is_admin]
  end

  def get_client_name
    puts "Please enter the client's name."
    gets.chomp
  end

  def display_hours_worked_in_month(date_list, hours_worked_in_each)
    puts "\nHours worked per day in current month:"
    iterate_over_names_and_hours(date_list, hours_worked_in_each)
  end

  def display_hours_worked_per_project(timecodes, hours_worked_for_each)
    puts "\nHours worked per project type:"
    iterate_over_names_and_hours(timecodes, hours_worked_for_each)
  end

  def display_hours_worked_per_client(client_names, hours_worked_for_each)
    puts "\nHours worked per client:"
    iterate_over_names_and_hours(client_names, hours_worked_for_each)
  end

  def display_hours_worked_by_employee(employee_names, hours_worked_by_each)
    puts "\nHours worked per Employee:"
    iterate_over_names_and_hours(employee_names, hours_worked_by_each)
  end

  private

  def iterate_over_names_and_hours(name_list, hours_list)
    for i in 0..(name_list.length - 1)
      puts "#{name_list[i]}: #{hours_list[i]} hours."
    end
  end

  def iterate_through_list_with_numbers(specified_list)
    puts "\n"
    for counter in 1..(specified_list.length)
      puts "#{counter}: #{specified_list[counter-1]}"
    end
  end

end
