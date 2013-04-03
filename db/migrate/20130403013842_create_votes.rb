class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :voting_user_id
      t.integer :value
      t.integer :receiving_entry_id

      t.timestamps
    end
  end
end
