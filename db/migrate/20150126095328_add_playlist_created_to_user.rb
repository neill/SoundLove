class AddPlaylistCreatedToUser < ActiveRecord::Migration
  def change
    add_column :users, :playlist_created, :boolean, default: false
  end
end
