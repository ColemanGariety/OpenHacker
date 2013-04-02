class SessionsController < ApplicationController
  skip_before_filter :authenticate, :only => :create

  # POST /auth/github/callback
  def create
    # raise env['omniauth.auth'].to_yaml

    user = User.from_omniauth(env['omniauth.auth'])
    cookies.permanent[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in with GitHub."
  end

  # GET /logout
  def destroy
    cookies.delete :user_id

    redirect_to root_url, :notice => "Signed out."
  end
end