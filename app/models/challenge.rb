class Challenge < ActiveRecord::Base
  attr_accessible :description, :submitting_user_id, :title
end
