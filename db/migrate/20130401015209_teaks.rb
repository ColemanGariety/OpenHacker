class Teaks < ActiveRecord::Migration
  def change
    add_column :challenges, :approved, :boolean, :default => 0
  end
end
