class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :user_id
      t.string :name
      t.string :github_url
      t.string :description
      t.integer :challenge

      t.timestamps
    end
  end
end
