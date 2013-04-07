class AddGithubRepoId < ActiveRecord::Migration
  def change
    add_column :entries, :github_repo_id, :integer
  end
end
