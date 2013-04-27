class Entry < ActiveRecord::Base
  attr_accessible :description, :challenge_id, :repo_url, :user_id, :thumb_url, :title, :demo_url, :github_repo_id

  belongs_to :user
  belongs_to :challenge

  has_many :votes
  
  validates_uniqueness_of :github_repo_id
  
end
