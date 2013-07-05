class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge

  has_many :votes
  
  validates_uniqueness_of :github_repo_id
  validates_uniqueness_of :demo_url
  validates_uniqueness_of :repo_url
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :repo_url
  validates_presence_of :thumb_url
  validates_presence_of :demo_url
  validates_presence_of :github_repo_id
  
  def url
    if self.challenge.status == Challenge::STATUSES[:closed]
      self.demo_url
    else
      url_for(self)
    end
  end
end