require 'pry'
class MusicLibraryController
  
  attr_accessor :path 
  
  def initialize(path = "./db/mp3s")
    @path = path
    MusicImporter.new(path).import
  end
  
  def call 
    input = " "
    while input != "exit"
     puts "Welcome to your music library!"
     puts "To list all of your songs, enter 'list songs'."
     puts "To list all of the artists in your library, enter 'list artists'."
     puts "To list all of the genres in your library, enter 'list genres'."
     puts "To list all of the songs by a particular artist, enter 'list artist'."
     puts "To list all of the songs of a particular genre, enter 'list genre'."
     puts "To play a song, enter 'play song'."
     puts "To quit, type 'exit'."
     puts "What would you like to do?"
    
     input = gets.strip
     
     case input
     
      when "list songs"
        puts list_songs
      when "list artists"
        puts list_artists
      when "list genres"
        puts list_genres
      when "list artist"
        puts list_songs_by_artist
      when "list genre"
        puts list_songs_by_genre
      when "play song"
        puts play_song
      end
    end
  end
  
  def list_songs
    counter = 0
    Song.all.sort{|x, y| x.name <=> y.name}.each do |song|
      puts "#{counter + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
      counter += 1
      end
    end
    
    def list_artists
      counter = 0
      Artist.all.sort{|x, y| x.name <=> y.name}.each do |artist|
      puts "#{counter + 1}. #{artist.name}"
      counter += 1
      end
    end
    
    def list_genres
      counter = 0
      Genre.all.sort{|x, y| x.name <=> y.name}.each do |genre|
      puts "#{counter + 1}. #{genre.name}"
      counter += 1
      end
    end
    
    def list_songs_by_artist
      puts "Please enter the name of an artist:"
      input = gets.strip
      
      if artist = Artist.find_by_name(input)
       counter = 0
      artist.songs.sort{|x, y| x.name <=> y.name}.each do |song|
      puts "#{counter + 1}. #{song.name} - #{song.genre.name}"
      counter += 1
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    
    if genre = Genre.find_by_name(input)
       counter = 0
      genre.songs.sort{|x, y| x.name <=> y.name}.each do |song|
      puts "#{counter + 1}. #{song.artist.name} - #{song.name}"
      counter += 1
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i

    if (1..Song.all.length).include?(input)
    songs = Song.all.sort{|x, y| x.name <=> y.name} 
      song = songs[input - 1]
      puts "Playing #{song.name} by #{song.artist.name}"
     end
  end
  
  
end 