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

  # 12:00 AM Monday, PST
  def weekly
    # Open approved challenge
  	open_challenge = Challenge.find_by_status(Challenge::STATUSES[:approved])
  	if open_challenge && !open_challenge.entries.empty?
    	open_challenge.update_attributes(:status => Challenge::STATUSES[:open], :opened_at => Time.now)
    	open_challenge.save
  	end

  	# Move open challenge into voting
  	voting_challenge = Challenge.find_by_status(Challenge::STATUSES[:open])
  	if voting_challenge && !voting_challenge.entries.empty?
    	voting_challenge.status = Challenge::STATUSES[:voting]
    	voting_challenge.save
  	end

  	# Close the voting challenge
  	closed_challenge = Challenge.find_by_status(Challenge::STATUSES[:voting])
  	if closed_challenge && !closed_challenge.entries.empty?
  	  closed_challenge.status = Challenge::STATUSES[:closed]
  	  closed_challenge.save
  	end
  end
end