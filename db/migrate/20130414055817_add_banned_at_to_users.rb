class AddBannedAtToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :banned_at, :string
  end
end
