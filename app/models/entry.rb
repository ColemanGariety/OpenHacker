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
  validates_presence_of :demo_url
  validates_presence_of :github_repo_id
  
  def url
    self.challenge.status == Challenge::STATUSES[:closed] ? self.demo_url : self
  end
  
  def score
    Vote.where(:entry_id => self.id).map {|e| e.value }.inject { |sum, el| sum + el }.to_f
  end
  
  def ribbons
    Ribbon.where(:entry_id => self.id)
  end
  
  def screenshot_url
    "http://openhacker.co/shots/#{self.github_repo_id}"
  end
end