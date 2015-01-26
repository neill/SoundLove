class SoundsController < ApplicationController
    def index
        @user = current_user
        client = Soundcloud.new(access_token: current_user.token)
        playlist = client.get('/me/playlists/soundloved-tracks')
        @tracks = client.get('/tracks', genres: @genres)
        # Oembed seems cool, but this is printing literal HTML in the view.
        #track_url = 'http://soundcloud.com/forss/flickermood'
        #@embed_info = client.get('/oembed', :url => track_url)

        if current_user.playlist_created == false
            client.post('/playlists', playlist: {
            :title => "SoundLove'd Tracks",
            :sharing => 'public'
            #:tracks => tracks
            })

            current_user.playlist_created = true
            current_user.save!
        end
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
