class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :github_uid
      t.string :username
      t.string :email
      t.string :full_name
      t.string :avatar_url
      t.string :blog_url
      t.string :company
      t.string :location
      t.boolean :hireable
      t.text :bio

      t.timestamps
    end
  end
end
