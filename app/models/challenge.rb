class Challenge < ActiveRecord::Base
  attr_accessor :voted_percentage

  belongs_to :user

  has_many :votes, :through => :entries
  has_many :entries
end