class SoundsController < ApplicationController
    before_action :authenticate_user!, only: :index

    def variables
        @user = current_user
        @client = Soundcloud.new(access_token: current_user.token)
        @tracks = @client.get('/tracks', genres: @genres)

    end

    def index
        variables
        @track = @tracks.sample
        current_user.lastid = @track.id
        current_user.save!
        # Oembed seems cool, but this is printing literal HTML in the view.
        #track_url = 'http://soundcloud.com/forss/flickermood'
        #@embed_info = @client.get('/oembed', :url => track_url)

        if current_user.playlist_created == false
            @client.post('/playlists', playlist: {
            :title => "SoundLove'd Tracks",
            :sharing => 'public'
            })

            current_user.playlist_created = true
            current_user.save!
        end
    end

    def post_playlist
        variables
        @playlist = @client.get('/me/playlists/soundloved-tracks')
        @tracklist = []
        @playlist.tracks.each do |x|
            @tracklist << x.id
        end
        @tracklist << current_user.lastid
        @client.put(@playlist.uri, playlist: { tracks: @tracklist.map { |id| {:id => id} }  })
        redirect_to root_path
    end

    private
    def genre_list
        @genres2 = ['Metal', 'Rap']

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
