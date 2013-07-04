class Challenge < ActiveRecord::Base
  belongs_to :user

  has_many :votes, :through => :entries
  has_many :entries
end