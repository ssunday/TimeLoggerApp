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

  def username_is_not_in_system_message
    puts "Sorry, but that username is not in our system."
  end

  def specify_date_and_time
    date = specify_date
    time = specify_time
    date + " " + time
  end

  def get_hours_worked
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
    available_timecodes[select_option - 1]
  end

  def select_client(clients)
    puts "Please select client: "
    iterate_through_list_with_numbers(clients)
    clients[select_option - 1]
  end

  def select_option
    puts "\nPlease select which option by choosing the number."
    option = gets.chomp
    while option =~ /\A\d+\z/ ? false : true
      invalid_option_message
      option = gets.chomp
    end
    option.to_i
  end

  def invalid_option_message
    puts "\nThat is an invalid option. Please try again."
  end

  def get_employee_info(employee_names)
    username = get_employee_username(employee_names)
    is_admin = get_whether_employee_admin
    [username, is_admin]
  end

  def get_client_name(client_names)
    puts "Please enter the client's name."
    new_client = gets.chomp
    while client_names.include?(new_client)
      puts "Sorry, that client already exists. Please enter a new one."
      new_client = gets.chomp
    end
    [new_client]
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

  def date_valid?(inputted_date)
    date_collection = inputted_date.split('/')
    year = date_collection[2].to_i
    month = date_collection[1].to_i
    day = date_collection[0].to_i
    Date.valid_date?(year, month, day) == false || Date.parse(inputted_date) > Date.today
  end

  def get_employee_username(employee_names)
    puts "Please enter employee's username."
    username = gets.chomp
    while employee_names.include?(username)
      puts "Sorry, that username is already taken. Please enter a new one."
      username = gets.chomp
    end
    username
  end

  def get_whether_employee_admin
    puts "Please enter true if they are admin and false if they are not."
    is_admin = gets.chomp
    while is_admin != "true" &&  is_admin != "false"
      puts "Invalid option. Try again."
      is_admin = gets.chomp
    end
    is_admin.eql?("true")
  end

  def specify_date
    puts "Input date you wish to add hours worked for in day/month/year format. Example: 15/7/2012."
    inputted_date = gets.chomp
    while date_valid?(inputted_date)
      puts "Sorry, that date is invalid."
      inputted_date = gets.chomp
    end
    Date.parse(inputted_date).strftime('%-d/%-m/%Y')
  end

  def specify_time
    puts "Specify the time that you are logging this at in HH:MM AM/PM format or military format."
    inputted_time = gets.chomp
    bad_time = true
    while bad_time
      begin
        Time.parse(inputted_time)
        bad_time = false
      rescue ArgumentError
        puts "Sorry, that time is invalid."
        inputted_time = gets.chomp
      end
    end
    Time.parse(inputted_time).strftime("%k:%M")
  end


  def iterate_over_names_and_hours(name_list, hours_list)
    if name_list.length == 0
      puts "No data."
    else
      for i in 0..(name_list.length - 1)
        puts "#{name_list[i]}: #{hours_list[i]} hours."
      end
    end
  end

  def iterate_through_list_with_numbers(specified_list)
    puts "\n"
    for counter in 1..(specified_list.length)
      puts "#{counter}: #{specified_list[counter-1]}"
    end
  end

end
