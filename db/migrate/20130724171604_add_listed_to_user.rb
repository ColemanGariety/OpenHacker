class AddListedToUser < ActiveRecord::Migration
  def change
    add_column :users, :listed, :boolean
  end
end
