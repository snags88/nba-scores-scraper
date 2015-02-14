require_relative '../config/environment.rb'

class Cli
  def initialize
    puts "Welcome to NBA Scores CLI. "
    loop do
      puts "Type in a date: (i.e. Today, Yesterday, 2/19/2015, etc)"
      input = get_date
      case input
      when 'exit'
        break
      when 'help'
        help
      else
        valid_date?(input) ? Scores.new("nba", numerical_date(input)) : (puts "Invalid input.")
      end
    end
    puts "Thanks for using NBA Scores CLI! Bye!"
  end

  def main_menu
    puts "Main menu: Type 'help' for options."
  end

  def get_date
    raw_date = get_input
    help("date_selection") if raw_date == "help"
    raw_date
  end

  def get_input
    print "> "
    gets.strip.downcase
  end

  def valid_date?(date)
    valid_date = ["today", "yesterday", "tomorrow", "exit"]
    flag = false
    if valid_date.include?(date) || date[/\A\d{1,2}\/\d{1,2}\/\d{4}\Z/]
      flag = true
    end
    flag
  end

  def numerical_date(date)
    case date
    when "today"
      date = DateTime.parse(Time.now.to_s).strftime("%d/%m/%Y")
    when "yesterday"
      date = DateTime.parse(Date.today.prev_day.to_s).strftime("%d/%m/%Y")
    when "tomorrow"
      date = DateTime.parse(Date.today.next_day.to_s).strftime("%d/%m/%Y")
    else
      temp_date = date.split("/")
      temp_date[0], temp_date[1] = temp_date[1], temp_date[0]
      date = temp_date.join("/")
    end
      date_a = date.split("/").reverse
      date_a[1] = "0" + date_a[1] if date_a[1].length == 1
      date_a[2] = "0" + date_a[2] if date_a[2].length == 1
      date_a.join
  end

  def help
    puts "Type in Today, Yesterday, Tomorrow, or the date in the format of MM/DD/YYYY."
    puts "or type in exit."
  end
end