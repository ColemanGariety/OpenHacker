class AddBackOpenedAt < ActiveRecord::Migration
  def change
    add_column :challenges, :opened_at, :datetime
  end
end
