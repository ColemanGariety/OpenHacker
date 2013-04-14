class ChangeLevelToRibbons < ActiveRecord::Migration
  def change
	  rename_column :users, :level, :ribbon_array
  end

end
