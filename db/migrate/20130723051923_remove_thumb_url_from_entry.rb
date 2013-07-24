class RemoveThumbUrlFromEntry < ActiveRecord::Migration
  def change
    remove_column :entries, :thumb_url
  end
end
