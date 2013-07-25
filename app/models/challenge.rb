class Challenge < ActiveRecord::Base
  attr_accessor :voted_percentage

  has_many :users, :through => :entries

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
  def self.weekly
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
  	  
  	  # Award ribbons
  	  winners = closed_challenge.entries.sort_by { |entry| -entry.score }.take(3)
  	  winners.each_width_index do |winner, i|
  	    ribbon = Ribbon.new(:name => (i == 0 ? "blue" : i == 1 ? "yellow" : "red"), :user_id => winner.user_id, :entry_id => winner.id)
  	  end
  	end
  end
  
  def rules_array
    self.rules.split(',')
  end

  def prizes_array
    self.prize.split(',')
  end
end