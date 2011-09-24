class SessionsController < ApplicationController
  def new
    redirect_to root_path, :notice => "You are already logged in!" if not session[:user_id].nil?
  end

  def create
    user = User.find_by_username(params[:username])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to get_redirect, :notice => "Logged in as #{user.username}."
    else
      flash[:notice] = "Failed to login."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "You are logged out."
  end
end
