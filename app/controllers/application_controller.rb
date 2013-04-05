class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate

private

  def current_user
    User.find(cookies[:user_id]) if cookies[:user_id]
  end

  def current_open_challenge
    Challenge.find_by_status(2)
  end

  def current_voting_challenge
    Challenge.find_by_status(3)
  end

  def current_closed_challenge
    Challenge.find_by_status(4)
  end

  helper_method :current_user, :current_open_challenge, :current_voting_challenge, :current_closed_challenge

  def authenticate
    redirect_to "/auth/github" unless current_user
  end
end
