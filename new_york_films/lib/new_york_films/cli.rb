require_relative "film_finder.rb"

class NewYorkFilms::CLI

def call
  prompt
end


def prompt
  puts "Today's film screenings in NYC:"
  NewYorkFilms::FilmFinder.scraper
  x = NewYorkFilms::FilmFinder.all
  x.each do |film|
    puts "\n" + "THEATER: #{film.theater}\n" + "FILM: #{film.title}\n" + "DIRECTOR: #{film.director}\n" + "YEAR: #{film.year} - LENGTH: #{film.length}\n" + "TIMES: #{film.times}\n" + "MORE INFO: #{film.website}\n" + "LOCATION: #{film.location}"
  end

end





end
