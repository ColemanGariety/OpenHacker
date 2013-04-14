class Vote < ActiveRecord::Base
  attr_accessible :entry_id, :value, :user_id

  belongs_to :user
  belongs_to :challenge
  belongs_to :entry
end
