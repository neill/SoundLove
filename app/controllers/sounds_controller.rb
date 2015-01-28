class SoundsController < ApplicationController
    before_action :authenticate_user!, only: :index

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
end
