class Challenge < ActiveRecord::Base
  attr_accessor :voted_percentage

  belongs_to :user

  has_many :votes, :through => :entries
  has_many :entries

  # Challenge statuses
  STATUSES = {
    :suggested => 0,
    :approved => 1,
    :open => 2,
    :voting => 3,
    :closed => 4
  }
end