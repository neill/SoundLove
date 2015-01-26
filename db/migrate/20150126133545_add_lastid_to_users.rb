class AddLastidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lastid, :string
  end
end
