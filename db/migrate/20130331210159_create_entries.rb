class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.text :description
      t.string :repo_url
      t.string :thumb_url
      t.integer :submitting_user_id
      t.integer :receiving_challenge_id

      t.timestamps
    end
  end
end
