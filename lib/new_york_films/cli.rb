require_relative "film_finder.rb"

class NewYorkFilms::CLI

def call
  prompt
end


def prompt(input=nil)
  if input == nil
      puts "\n" + "Welcome to today's listing for arthouse film screenings in NYC. \nWould you like to see 1. All or 2. Listings by theater?"
      input = gets.chomp
      case input
      when "1", "all", "1."
        show_all
      when "2", "by theater", "2."
        theater_select
      when "exit"
       hard_out
      else
        puts "Please type 1 or 2 to see listings."
        prompt
      end
  elsif input == "1"
    show_all
  elsif input == "2"
    theater_select
  end
end

def show_all
  NewYorkFilms::FilmFinder.scraper
  x = NewYorkFilms::FilmFinder.all
  x.each do |film|
    puts "\n" + "THEATER: #{film.theater}\n" + "FILM: #{film.title}\n" + "DIRECTOR: #{film.director}\n" + "YEAR: #{film.year} - LENGTH: #{film.length}\n" + "TIMES: #{film.times}\n" + "MORE INFO: #{film.website}\n" + "LOCATION: #{film.location}"
  end
  what_next?
end


def theater_select
  puts "Enter the number of the theater you'd like to see:"
  NewYorkFilms::FilmFinder.theater_scraper
  x = NewYorkFilms::FilmFinder.theaters.uniq
  x.each.with_index(1) do |film,index|
   puts "#{index}. #{film}"
  end
 answer = gets.chomp
 theater_choice = "#{x.at(answer.to_i - 1)}"
    if answer.to_i.between?(1,x.length+1)
       choose_theater(theater_choice)
    elsif answer == "exit"
      hard_out
    else
      puts "Please enter a correct number."
      prompt("2")
    end
end



def choose_theater(input)
  NewYorkFilms::FilmFinder.scraper
  NewYorkFilms::FilmFinder.all.each do |film|
    if film.theater == input
      puts "\n" + "THEATER: #{film.theater}\n" + "FILM: #{film.title}\n" + "DIRECTOR: #{film.director}\n" + "YEAR: #{film.year} - LENGTH: #{film.length}\n" + "TIMES: #{film.times}\n" + "MORE INFO: #{film.website}\n" + "LOCATION: #{film.location}"
    end
  end
  what_next?
end

def what_next?
  puts "\n"+"Would you like to 1. Go back to main menu or 2. Exit?"
  input = gets.chomp.downcase
  case input
  when "1", "menu", "1."
    prompt
  when "2", "2.", "exit"
    hard_out
  else
    puts "Not sure what you meant. Please enter 1 to go to the menu or 2 to exit."
    what_next?
  end
end

def hard_out
  puts "\n"+"'No art passes our conscience in the way film does, and goes directly to our feelings, deep down into the dark rooms of our souls.'\n   -Ingmar Bergman"
  exit
end



end
