class UsersController < ApplicationController
  before_filter :set_user, only: [:show, :edit, :update]

  def index
    if current_user.admin?
      @users = User.all
    else
      redirect_to root_path, alert: "Access denied"
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    sanitize_params

    @user = User.new(params[:user])

    if @user.save
      redirect_to users_path, notice: "New user was created."
    else
      render "new"
    end
  end

  def update
    sanitize_params

    if @user.update_attributes(params[:user])
      redirect_to user_path(@user)
    else
      render action: "edit"
    end
  end

  private

  def set_user
    if current_user.admin? || current_user.id == params[:id]
      @user = User.find(params[:id])
    else
      redirect_to root_path, alert: "Access denied"
    end
  end

  def sanitize_params
    unless current_user.admin?
      params[:user].delete(:organization_id)
    end
  end
end
