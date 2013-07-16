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

    @entries = Entry.where(:user_id => @user.id)

    @challenges = Challenge.where(:user_id => @user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
end