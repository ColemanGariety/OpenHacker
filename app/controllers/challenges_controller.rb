class ChallengesController < ApplicationController
  # GET /challenge
  # GET /challenge.json
  def index
    @challenges = Challenge.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @challenges }
    end
  end

  # GET /suggestions
  # GET /suggestions.json
  def suggestions
    @challenges = Challenge.all

    respond_to do |format|
      format.html
      format.json { render json: @challenges }
    end
  end

  # GET /challenge/1
  # GET /challenge/1.json
  def show
    @challenge = Challenge.find(params[:id])

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
  	redirect_to root_url unless current_user.level == 1
    @challenge = Challenge.find(params[:id])
  end

  # POST /challenge
  # POST /challenge.json
  def create
    @challenge = Challenge.new(params[:challenge])

    @challenge.submitting_user_id = current_user.id

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
      if @challenge.update_attributes(params[:challenge])
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PUT Runs every sunday night to update the week's challenge
  def cron
  	open_challenge = Challenge.find_by_status(1)
  	open_challenge.update_attributes(:status => 2, :opened_at => Time.now)
  	open_challenge.save

  	voting_challenge = Challenge.find_by_status(2)
  	voting_challenge.status = 3
  	voting_challenge.save
  	
  	closed_challenge = Challenge.find_by_status(3)
  	closed_challenge.status = 4
  	closed_challenge.save
  end

  # DELETE /challenge/1
  # DELETE /challenge/1.json
  def destroy
 	  redirect_to root_url unless current_user.level == 1
    @challenge = Challenge.find(params[:id])
    @challenge.destroy

    respond_to do |format|
      format.html { redirect_to challenge_suggestions_path }
      format.json { head :no_content }
    end
  end
end
