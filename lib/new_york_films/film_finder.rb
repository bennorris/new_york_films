require 'nokogiri'
require 'open-uri'
require_relative "./screening.rb"

class NewYorkFilms::FilmFinder

@@all_films = []
@@theaters = []

def self.theaters
  @@theaters
end

def self.all
  @@all_films
end

def self.scraper
  doc = Nokogiri::HTML(open("http://www.screenslate.com/"))

  doc.search("ul li.screenings__venue___2EEUR li.screenings__screening___2wxaa").map do |film|
    @@all_films << screening = NewYorkFilms::Screening.new

      if film.parent.parent.css("h3") != nil
        screening.theater = film.parent.parent.css("h3").text
      else
        screening.theater = "not provided"
      end

      if film.css("a.screening__link___1rTIP") != nil
        screening.title = film.css("a.screening__link___1rTIP").text
      else
        screening.title = "not provided"
      end


      if film.search("div.screening__details___2yckE span")[0] != nil
        screening.director = film.search("div.screening__details___2yckE span")[0].text
      else
        screening.director = "Not listed."
      end

      if film.search("div.screening__details___2yckE span")[1] != nil
        screening.year = film.search("div.screening__details___2yckE span")[1].text
      else
        screening.year = "not provided"
      end

      if film.search("div.screening__details___2yckE span")[2] != nil
        screening.length = film.search("div.screening__details___2yckE span")[2].text
      else
        screening.length = "not provided"
      end

      if film.search("div.screening__showtimespacing___17fBg span.screening__showtime___3oJD6") != nil
        screening.times = film.search("div.screening__showtimespacing___17fBg span.screening__showtime___3oJD6").text.gsub("pm","pm  ").gsub("am", "am  ")
      else
        screening.times = "not provided"
      end


      if film.search("a.screening__link___1rTIP").attribute("href").value == nil
        film.search("a.screening__link___1rTIP").attribute("href").value = "http://www.screenslate.com/"
      end

      if film.search("a.screening__link___1rTIP") != nil
        screening.website = film.search("a.screening__link___1rTIP").attribute("href").value
      else
        screening.website = "not provided"
      end


      contact = film.parent.parent.css("a").attribute("href").value
      venue = Nokogiri::HTML(open("http://www.screenslate.com#{contact}"))

      if venue.css("div.venue__info___2bLnH p") != nil
        screening.location = venue.css("div.venue__info___2bLnH p").first.text.gsub("Location ", "") if venue.css("div.venue__info___2bLnH p").first.text.include?(", NY")
        screening.location = venue.css("div.venue__info___2bLnH p")[1].text.gsub("Location ", "") if venue.css("div.venue__info___2bLnH p")[1].text.include?(", NY")
      else
        screening.location = "please see theater's website."
      end
    end
  end

  def self.theater_scraper
    doc = Nokogiri::HTML(open("http://www.screenslate.com/"))
    doc.search("ul li.screenings__venue___2EEUR li.screenings__screening___2wxaa").each do |film|
      @@theaters << film.parent.parent.css("h3").text
    end
    @@theaters
  end


end
