class RailsDefaultColumn < ActiveRecord::Migration
  def change
    rename_column :votes, :voting_user_id, :user_id
    rename_column :votes, :receiving_entry_id, :entry_id
    rename_column :entries, :submitting_user_id, :user_id
    rename_column :entries, :receiving_challenge_id, :challenge_id
    rename_column :challenges, :submitting_user_id, :user_id
  end
end
