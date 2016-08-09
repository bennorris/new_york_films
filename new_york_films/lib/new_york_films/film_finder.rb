require 'nokogiri'
require 'open-uri'
require 'pry'

class NewYorkFilms::Screening
  attr_accessor :theater, :title, :times, :director, :year, :length, :website, :location
  def initialize(attributes = {})
    @theater = attributes[:theater]
    @title = attributes[:title]
    @director = attributes[:director]
    @times = attributes[:times]
    @year = attributes[:year]
    @length = attributes[:length]
    @website = attributes[:website]
    @location = attributes[:location]
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

      if film.search("a.screening__link___1rTIP").attribute("href").value == nil
        film.search("a.screening__link___1rTIP").attribute("href").value = "http://www.screenslate.com/"
      end
      screening.website = film.search("a.screening__link___1rTIP").attribute("href").value

      # binding.pry
      contact = film.parent.parent.css("a").attribute("href").value
      venue = Nokogiri::HTML(open("http://www.screenslate.com#{contact}"))

      screening.location = venue.css("div.venue__info___2bLnH p").first.text.gsub("Location ", "") if venue.css("div.venue__info___2bLnH p").first.text.include?(", NY")
      screening.location = venue.css("div.venue__info___2bLnH p")[1].text.gsub("Location ", "") if venue.css("div.venue__info___2bLnH p")[1].text.include?(", NY")

      end
  end











end
