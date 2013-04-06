class AddDemoUrlToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :demo_url, :string
  end
end
