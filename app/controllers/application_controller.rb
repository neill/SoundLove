class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    def variables
        @user = current_user
        @client = Soundcloud.new(access_token: current_user.token)
        @tracks = @client.get('/tracks', genres: @genres)
        @playlist = @client.get('/me/playlists/soundloved-tracks')
    end


    def post_playlist
        variables
        @tracklist = []
        @playlist.tracks.each do |x|
            @tracklist << x.id
        end
        @tracklist << current_user.lastid
        @client.put(@playlist.uri, playlist: { tracks: @tracklist.map { |id| {:id => id} }  })
        redirect_to root_path
    end

    def genre_list
        @genres = ['Alternative Rock',
                    'Ambient',
                    'Classical',
                    'Country',
                    'Dance',
                    'Deep House',
                    'Disco',
                    'Drum & Bass',
                    'Dubstep',
                    'Electro',
                    'Electronic',
                    'Folk',
                    'Hardcore Techno',
                    'Hip Hop',
                    'House',
                    'Indie Rock',
                    'Jazz',
                    'Latin',
                    'Metal',
                    'Minimal Techno',
                    'Piano',
                    'Pop',
                    'Progressive House',
                    'Punk',
                    'R&B',
                    'Rap',
                    'Reggae',
                    'Rock',
                    'Singer-Songwriter',
                    'Soul',
                    'Tech House',
                    'Techno',
                    'Trance',
                    'Trap',
                    'Trip Hop',
                    'World',]
    end
end