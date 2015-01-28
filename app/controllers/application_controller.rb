class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    def variables
        @user = current_user
        @client = Soundcloud.new(access_token: current_user.token)
        @tracks = @client.get('/tracks')
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
end