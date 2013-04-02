class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate

private

  def current_user
    @current_user ||= User.find(cookies[:user_id]) if cookies[:user_id]
  end

  def time_of_day
    t = Time.now
    t.hour >= 0 && t.hour < 12 ? :morning : t.hour >= 12 && t.hour < 17 ? :afternoon : t.hour >= 17 && t.hour <= 23 ? :evening : nil
  end

  helper_method :current_user, :time_of_day


  def authenticate
    redirect_to "/auth/github" unless current_user
  end
end
