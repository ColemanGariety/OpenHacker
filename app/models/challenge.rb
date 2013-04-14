class Challenge < ActiveRecord::Base
  attr_accessible :description, :user_id, :title

  belongs_to :user

  has_many :votes
  has_many :entries
end
