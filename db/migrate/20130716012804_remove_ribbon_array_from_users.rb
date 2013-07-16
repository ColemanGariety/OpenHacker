class RemoveRibbonArrayFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :ribbon_array
  end
end
