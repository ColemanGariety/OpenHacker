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

    @user = @challenge.user

    @entries = @challenge.entries

    votes = @entries.collect(&:votes).flatten

    @voted_percentage = ((votes.select { |v| v.user_id == current_user.id }.flatten.count.to_f / @entries.count.to_f) * 100).to_i

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
    @challenge = Challenge.new(params[:challenge])

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
      if @challenge.update_attributes(params[:challenge])
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # 11:59 PM Sunday, PST
  def cron

    # Open approved challenge
  	open_challenge = Challenge.find_by_status(1)
  	if open_challenge && !open_challenge.entries.empty?
    	open_challenge.update_attributes(:status => 2, :opened_at => Time.now)
    	open_challenge.save
  	end

  	# Move open challenge into voting
  	voting_challenge = Challenge.find_by_status(2)
  	if voting_challenge && !voting_challenge.entries.empty?
    	voting_challenge.status = 3
    	voting_challenge.save
  	end

  	# Close the voting challenge
  	closed_challenge = Challenge.find_by_status(3)
  	if closed_challenge && !closed_challenge.entries.empty?
  	  closed_challenge.status = 4
  	  closed_challenge.save
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
end
