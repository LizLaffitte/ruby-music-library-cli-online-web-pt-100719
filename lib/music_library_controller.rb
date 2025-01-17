class MusicLibraryController
    
    def initialize(path = './db/mp3s')
        MusicImporter.new(path).import
    end

    def call
        input = nil
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
            input = gets.chomp
            case input
            when "list songs"
                list_songs
            when "list artists"
                list_artists
            when "list genres"
                list_genres
            when "list artist"
                list_songs_by_artist
            when "list genre"
                list_songs_by_genre
            when "play song"
                play_song
            end
       
        end
        
    end

    def list_songs
        Song.all.sort_by(&:name).each.with_index(1){|song, idx| puts "#{idx}. #{song.artist.name} - #{song.name} - #{song.genre.name}"}
    end

    def list_artists
        Artist.all.sort_by(&:name).each.with_index(1){|artist, idx| puts "#{idx}. #{artist.name}"}
    end
    
    def list_genres
        Genre.all.sort_by(&:name).each.with_index(1){|genre, idx| puts "#{idx}. #{genre.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        name = gets.chomp
        artist = Artist.find_by_name(name)
        if artist != nil
            artist.songs.sort_by(&:name).each.with_index(1){|song, idx| puts "#{idx}. #{song.name} - #{song.genre.name}"}
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        name = gets.chomp
        genre = Genre.find_by_name(name)
        if genre != nil
            genre.songs.sort_by(&:name).each.with_index(1){|song, idx| puts "#{idx}. #{song.artist.name} - #{song.name}"}
        end
    end

    def play_song  
        puts "Which song number would you like to play?"
        song_choice_index = (gets.chomp.to_i) - 1
        if Song.all.length > song_choice_index && song_choice_index > 0
            song = Song.all.sort_by(&:name)[song_choice_index]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end
end