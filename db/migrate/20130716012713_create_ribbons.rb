class CreateRibbons < ActiveRecord::Migration
  def change
    create_table :ribbons do |t|
      t.string :type
      t.string :user_id
      t.string :entry_id

      t.timestamps
    end
  end
end
