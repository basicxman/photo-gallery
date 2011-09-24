class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  # User authentication
  def user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :user

  def authenticate_user
    if user.nil?
      redirect_to login_path(:landing_page => request.fullpath), :notice => "Need to be logged in to see this page!"
    end
  end

  def get_redirect
    validate_landing(params[:landing_page]) || root_path
  end

  def validate_landing(url)
    return nil if url.nil?
    return nil unless url[0] == "/" && url.index(/^\/\//).nil?
    return url
  end
end
