class SoundsController < ApplicationController
    def index
        @user = current_user
        client = Soundcloud.new(access_token: current_user.token)

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
end
