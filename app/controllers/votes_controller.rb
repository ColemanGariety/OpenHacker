class VotesController < ApplicationController
  # POST /votes
  # POST /votes.json
  def vote
    @vote = Vote.find_or_initialize_by_value_and_receiving_entry_id_and_voting_user_id(params[:value], params[:receiving_entry_id], current_user.id)

    respond_to do |format|
      if @vote.save
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end
end
