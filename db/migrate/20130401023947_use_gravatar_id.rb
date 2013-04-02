class UseGravatarId < ActiveRecord::Migration
  def change
    rename_column :users, :avatar_url, :gravatar_id
  end
end
