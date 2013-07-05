class AddIndexesToVotesChallengesEntriesAndUsers < ActiveRecord::Migration
  def self.up
  	add_index :entries, [:challenge_id, :user_id]
  	add_index :votes, [:value, :entry_id, :user_id]
  	add_index :challenges, [:status, :opened_at]
  end

  def self.down
  	remove_index :entries, [:challenge_id, :user_id]
  	remove_index :votes, [:value, :entry_id, :user_id]
  	remove_index :challenges, [:status, :opened_at]
  end
end
