class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.id
    session[:screen_name] = auth[:info][:nickname]
    session[:name] = auth[:info][:name]
    session[:user_token] = auth['credentials']['token']
    session[:user_secret] = auth['credentials']['secret']
    redirect_to root_path, notice: "Signed in successfully."
  end

  def destroy
    session[:user_id] = nil
    session[:screen_name] = nil
    session[:user_token] = nil
    session[:user_secret] = nil
    redirect_to root_path, notice: "Signed out successfully."
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end