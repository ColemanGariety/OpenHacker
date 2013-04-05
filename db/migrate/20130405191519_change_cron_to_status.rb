class ChangeCronToStatus < ActiveRecord::Migration
  def change
    remove_column :challenges, :opened_at
    remove_column :challenges, :approved
    add_column :challenges, :status, :integer
  end
end
