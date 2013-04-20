class Vote < ActiveRecord::Base
  attr_accessible :entry_id, :value, :user_id

  belongs_to :user
  belongs_to :entry

  def challenge
    self.entry.challenge
  end
end
