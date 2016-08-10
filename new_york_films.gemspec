# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/new_york_films/version'

Gem::Specification.new do |spec|
  spec.name          = "new_york_films"
  spec.version       = NewYorkFilms::VERSION
  spec.authors       = ["Ben Norris"]
  spec.email         = ["bennorris07@gmail.com"]

  spec.summary       = "Today's independent movies in NYC"
  spec.description   = "Art house films across the city"
  spec.homepage      = "http://www.github.com/bennorris"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = ["bin/new_york_films","bin/setup","lib/new_york_films/cli.rb","lib/new_york_films/film_finder.rb", "lib/new_york_films/new_york_films.rb", "lib/new_york_films/version.rb", "lib/new_york_films/screening.rb"]
  spec.bindir        = "bin"
  spec.executables   = "new_york_films"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'nokogiri'
end
