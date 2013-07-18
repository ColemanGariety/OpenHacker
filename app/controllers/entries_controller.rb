class EntriesController < ApplicationController
  before_filter :authenticate, :only => :new

  # GET /entries
  # GET /entries.json
  def index
    if current_closed_challenge.present?
      @entries = Entry.where(:challenge_id => current_closed_challenge.id).limit(3)
      
      @closed_challenge_count = Challenge.where("status = ? OR status = ?", 3, 4).count
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: Entry.all }
      end
    else
      respond_to do |format|
        format.html { render "challenges/about" }
      end
    end
  end

  def top
  	@entries = Entry.where(:challenge_id => current_closed_challenge.id)
  		.joins("LEFT JOIN votes ON entries.id = votes.entry_id")
  		.select("entries.id," +
        "sum(value) as score," +
        "entries.title," +
        "description," +
        "repo_url," +
        "thumb_url," +
        "entries.user_id," +
        "challenge_id," +
        "entries.created_at," +
        "github_repo_id," +
        "platform"
  		)
      .group("entries.id")
      .order("sum(value) DESC")

    respond_to do |format|
      format.html
      format.json { render json: @entry }
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])

    if current_user
      vote = Vote.find_by_entry_id_and_user_id(@entry.id, current_user.id)
      @voted_value = vote ? vote.value : 0
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end
  
  # GET /entries/1/track
  # GET /entries/1/track.json
  def track
    @entry = Entry.find(params[:id])

    @vote = Vote.where(:entry_id => @entry.id)
    @user = User.find(@entry.user_id)

    respond_to do |format| # if current_user.id == @entry.user_id : redirect_to root_path end
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.json
  def new
    @challenge = current_open_challenge
    submission = Entry.find_by_challenge_id_and_user_id(@challenge.id, current_user.id)
    
    if submission.blank?
      @entry = Entry.new
    
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @entry }
      end
    else
      respond_to do |format|
        format.html { redirect_to submission }
        format.json { render json: submission }
      end
    end
  end

  # GET /entries/1/edit
  def edit
  	redirect_to root_url unless is_moderator(current_user)
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(entry_params)

    @entry.user_id = current_user.id
    @entry.challenge_id = current_open_challenge.id

    submission = Entry.find_by_challenge_id_and_user_id(@entry.challenge_id, @entry.user_id)
    
    if submission.blank?
      respond_to do |format|
        if @entry.save
          format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
          format.json { render json: @entry, status: :created, location: @entry }
        else
          format.html { render action: "new" }
          format.json { render json: @entry.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to submission }
        format.json { render json: submission }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
  	redirect_to root_url unless is_moderator(current_user)
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end
  
  def get_screen
    begin
      driver = Selenium::WebDriver.for(:firefox)
      driver.get("https://www.google.com")
      driver.save_screenshot('public/shots/screen.jpg')
    ensure
      driver.quit
    end
    
    render :text => "http://openhacker.io.dev/shots/screen.jpg"
  end

private

  def entry_params
    params.require(:entry).permit(:description, :challenge_id, :repo_url, :user_id, :thumb_url, :title, :demo_url, :github_repo_id)
  end
end