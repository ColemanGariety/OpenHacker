class Challenge < ActiveRecord::Base
  attr_accessible :description, :submitting_user_id, :title
  
  attr_accessor :is_moderator

  belongs_to :user

  has_many :votes
  has_many :entries
end
