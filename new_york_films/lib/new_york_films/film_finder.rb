require 'nokogiri'
require 'open-uri'
require 'pry'

class NewYorkFilms::Screening
  attr_accessor :theater, :title, :times, :director, :year, :length
  def initialize(attributes = {})
    @theater = attributes[:theater]
    @title = attributes[:title]
    @director = attributes[:director]
    @times = attributes[:times]
    @year = attributes[:year]
    @length = attributes[:length]
  end
end


class NewYorkFilms::FilmFinder


@@all_films = []

def self.all
  @@all_films
end

def self.scraper
  doc = Nokogiri::HTML(open("http://www.screenslate.com/"))

#   doc.search("ul li.screenings__venue___2EEUR").each do |film|
#     @@all_films << screening = NewYorkFilms::Screening.new
#     screening.theater = film.css("h3").text
#
#     film.search("li.screenings__screening___2wxaa").each do |subfilm|
#       binding.pry
#           screening.title = subfilm.css("a.screening__link___1rTIP").text
#           screening.details = subfilm.search("div.screening__details___2yckE span")[0].text
#           screening.times = subfilm.search("div.screening__showtimespacing___17fBg span.screening__showtime___3oJD6").text.gsub("pm","pm  ").gsub("am", "am  ")
#
#         end
#   end
# end

  doc.search("ul li.screenings__venue___2EEUR li.screenings__screening___2wxaa").each do |film|
    @@all_films << screening = NewYorkFilms::Screening.new
      screening.theater = film.parent.parent.css("h3").text
      screening.title = film.css("a.screening__link___1rTIP").text
      screening.director = film.search("div.screening__details___2yckE span")[0].text
      screening.year = film.search("div.screening__details___2yckE span")[1].text
      screening.length = film.search("div.screening__details___2yckE span")[2].text
      screening.times = film.search("div.screening__showtimespacing___17fBg span.screening__showtime___3oJD6").text.gsub("pm","pm  ").gsub("am", "am  ")
        end
  end











end
