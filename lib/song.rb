require 'pry'
class Song 
  
  extend Concerns::Findable
  
  attr_accessor :name
   attr_reader :artist, :genre

  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    @genre = genre 
    if artist != nil
      self.artist= artist 
    end
    if genre != nil
      self.genre = genre
    end
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
    song = new(name)
    song.save
    song
  end

  def artist=(artist)
    @artist = artist 
    artist.add_song(self)
  end
  
  def genre= (genre)
    @genre = genre
    genre.songs << self unless genre.songs.include? self
  end
  
  def self.find_by_name(name)
    self.all.detect {|song| song.name == name} 
  end
  
  def self.find_or_create_by_name(name)
    if self.find_by_name(name)  
      self.find_by_name(name)
    else
      Song.create(name)
    end
  end
  
  def self.new_from_filename(song)
      split_name = song.split(" - ")
      split_genre = split_name[2].split(".")
      artist = Artist.find_or_create_by_name(split_name[0])
      genre = Genre.find_or_create_by_name(split_genre[0]) 
      song = Song.find_or_create_by_name(split_name[1])
      song.artist = artist
      song.genre = genre
      song
  end
  
  def self.create_from_filename(song)
    # split_name = song.split(" - ")
    #   split_genre = split_name[2].split(".")
    #   artist = Artist.find_or_create_by_name(split_name[0])
    #   genre = Genre.find_or_create_by_name(split_genre[0]) 
    #   song = Song.find_or_create_by_name(split_name[1])
    #   song.artist = artist
    #   song.genre = genre
    new_song = self.new_from_filename(song)

  end
end
