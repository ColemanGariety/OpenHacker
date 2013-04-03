class Vote < ActiveRecord::Base
  attr_accessible :receiving_entry_id, :value, :voting_user_id

  belongs_to :user
  belongs_to :challenge
  belongs_to :entry
end
