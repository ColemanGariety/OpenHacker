class ChallengesController < ApplicationController
  # GET /challenge
  # GET /challenge.json
  def index
    @challenges = Challenge.where("status = ? OR status = ?", 3, 4)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @challenges }
    end
  end

  # GET /suggestions
  # GET /suggestions.json
  def suggestions
    @challenges = Challenge.where("status = #{Challenge::STATUSES[:suggested]} or status = #{Challenge::STATUSES[:approved]}")

    respond_to do |format|
      format.html
      format.json { render json: @challenges }
    end
  end

  # GET /challenge/1
  # GET /challenge/1.json
  def show
    @challenge = Challenge.find(params[:id])
    @challenge.votes = @challenge.entries.collect(&:votes).flatten
    @challenge.voted_percentage = ((@challenge.votes.select { |v| v.user_id == current_user.id }.flatten.count.to_f / @challenge.entries.count.to_f) * 100).to_i

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @challenge }
    end
  end

  # GET /challenge/new
  # GET /challenge/new.json
  def new
    @challenge = Challenge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @challenge }
    end
  end

  # GET /challenge/1/edit
  def edit
  	redirect_to root_url unless is_moderator(current_user)
    @challenge = Challenge.find(params[:id])
  end

  # POST /challenge
  # POST /challenge.json
  def create
    @challenge = Challenge.new(challenge_params)
    @challenge.status = 0
    @challenge.user_id = current_user.id

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to challenge_suggestions_path, notice: 'Challenge was successfully created.' }
        format.json { render json: @challenge, status: :created, location: @challenge }
      else
        format.html { render action: "new" }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /challenge/1
  # PUT /challenge/1.json
  def update
    @challenge = Challenge.find(params[:id])

    respond_to do |format|
      if @challenge.update_attributes(challenge_params)
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenge/1
  # DELETE /challenge/1.json
  def destroy
  	redirect_to root_url unless is_moderator(current_user)
    @challenge = Challenge.find(params[:id])
    @challenge.destroy

    respond_to do |format|
      format.html { redirect_to challenge_suggestions_path }
      format.json { head :no_content }
    end
  end

  def rules
  end

  def about
  end

private

  def challenge_params
    params.require(:challenge).permit(:description, :user_id, :title, :voted_percentage)
  end
end
