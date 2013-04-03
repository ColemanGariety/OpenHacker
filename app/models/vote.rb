class Vote < ActiveRecord::Base
  attr_accessible :receiving_entry_id, :value, :voting_user_id
end
