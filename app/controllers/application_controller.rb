class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate

private

  def current_user
    User.find(cookies[:user_id]) if cookies[:user_id]
  end

  def current_open_challenge
    Challenge.where(:approved => true).order("created_at DESC").first
  end

  def current_voting_challenge
    # Active record query for the challenge currently in voting
  end

  def current_closed_challenge
    # Active record query for the most recently ended challenge
  end

  helper_method :current_user, :current_open_challenge, :current_voting_challenge, :current_closed_challenge

  def authenticate
    redirect_to "/auth/github" unless current_user
  end
end
