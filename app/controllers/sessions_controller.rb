class SessionsController < ApplicationController
  skip_before_filter :authorize, except: :destroy

  def new
  end

  def create
    if user = User.find_by_name(params[:name]) and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to profile_path
    else
      flash.now.alert = "Invalid name or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end
