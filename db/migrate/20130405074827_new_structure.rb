class NewStructure < ActiveRecord::Migration
  def change
    add_column :challenges, :opened_at, :datetime
    add_column :challenges, :prize, :string
    add_column :challenges, :rules, :string
  end
end