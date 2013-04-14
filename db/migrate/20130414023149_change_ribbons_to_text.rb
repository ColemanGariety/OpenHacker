class ChangeRibbonsToText < ActiveRecord::Migration
  def change
		change_column :users, :ribbon_array, :text
	end
end