class Entry < ActiveRecord::Base
  attr_accessible :description, :receiving_challenge_id, :repo_url, :submitting_user_id, :thumb_url, :title, :demo_url

  belongs_to :user
  belongs_to :challenge

  has_many :votes
end
