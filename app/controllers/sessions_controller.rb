class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    session[:user_name] = user.name
    #render :text => "signed in"
    redirect_to root_url, :notice  => "signed in"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice  => "signed out"
  end

  def failure
    render :text => params[:message]
  end

end
