class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge

  has_many :votes
  
  validates_uniqueness_of :github_repo_id
end
