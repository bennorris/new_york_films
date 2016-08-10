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
