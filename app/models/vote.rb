class Vote < ActiveRecord::Base
  has_one :challenge

  belongs_to :user
  belongs_to :entry
end
