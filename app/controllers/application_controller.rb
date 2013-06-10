class ApplicationController < ActionController::Base
  #protect_from_forgery
  helper :all
  def require_login
    if session[:user_id].nil?
      redirect_to "/login", :notice => "Please Login to Enter"
    end
  end

 
 
  def current_user
    if !session[:user_id].nil?
      @current_user ||= User.find(session[:user_id])
    else
      @current_user
    end
    return @current_user
  end
  helper_method :current_user
end
