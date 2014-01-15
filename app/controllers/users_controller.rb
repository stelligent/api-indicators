class UsersController < ApplicationController
  before_filter :authorize

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path, notice: "New user was created."
    else
      render "new"
    end
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to profile_path
    else
      redirect_to edit_profile_path
    end
  end
end
