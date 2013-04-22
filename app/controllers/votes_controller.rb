class VotesController < ApplicationController
  before_filter :authenticate

  # POST /votes
  # POST /votes.json
  def vote
    @vote = Vote.find_or_initialize_by_entry_id_and_user_id(params[:entry_id], current_user.id)

    @previous_votes = current_user.votes.select { |v| v.entry.challenge_id == Entry.find(params[:entry_id]).challenge_id }

    if @previous_votes.count == 0
      @vote.ignore = true
    else
      @vote.ignore = false

      if @previous_votes.count == 1
        @previous_votes.each do |v|
          old_vote = Vote.find(v.id)
          old_vote.ignore = false
          old_vote.save!
        end
      end
    end

    @vote.value = params[:value]

    respond_to do |format|
      if @vote.save! && @previous_votes.each { |v| v.save! }
        format.html { redirect_to next_entry }
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html { redirect_to Entry.find(params[:entry_id]) }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end
end