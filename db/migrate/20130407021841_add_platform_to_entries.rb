class AddPlatformToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :platform, :string
  end
end
