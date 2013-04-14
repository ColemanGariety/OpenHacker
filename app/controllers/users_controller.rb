class UsersController < ApplicationController
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.json { render json: @users.map { |u| u.as_json(:only => :username) } }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find_by_username(params[:id])
    @entries = Entry.where(:submitting_user_id => @user.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  # PUT /users/ColbyAley/ban
  def ban
  	if is_moderator(current_user)
	  	user = User.find_by_username(params[:username])
	  	user.banned_at = Time.now.strftime('%Y%m%d')
	  	user.save
	  	render :nothing => true
	  else
	  	redirect_to index_path
	  end
  end
end