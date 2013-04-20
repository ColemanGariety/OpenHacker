class AddIgnoreToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :ignore, :boolean, :default => false
  end
end
