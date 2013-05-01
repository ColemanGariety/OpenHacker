class Vote < ActiveRecord::Base
  attr_accessible :entry_id, :value, :user_id

  has_one :challenge

  belongs_to :user
  belongs_to :entry
end
