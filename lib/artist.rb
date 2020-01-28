require 'pry'
require_relative './concerns/findable.rb'
class Artist 
  extend Concerns::Findable
   
  
  attr_accessor :name 

  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(name)
    artist = new(name)
    artist.save
    artist
  end

  def songs
    @songs
  end
  
  def add_song(song)
    song.artist = self unless song.artist
    @songs << song unless @songs.include?(song)
  end

  def genres 
     genre = []
     songs.map do |song|
       genre << song.genre unless genre.include?(song.genre)
     end
     genre
  end
   
   
end