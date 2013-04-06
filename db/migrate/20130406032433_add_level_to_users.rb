class AddLevelToUsers < ActiveRecord::Migration
  def change
	  add_column :users, :level, :integer
  end
end
