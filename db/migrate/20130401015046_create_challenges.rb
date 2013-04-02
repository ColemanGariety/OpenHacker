class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :title
      t.text :description
      t.integer :submitting_user_id

      t.timestamps
    end
  end
end
