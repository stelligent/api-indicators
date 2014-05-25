class Api::UsersController < ApiController
  before_filter :authorize_admin
  before_filter :get_user, only: [:show, :update, :destroy]

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(params[:user])
    @user.save

    render json: @user
  end

  def update
    @user.update_attributes(params[:user])

    render json: @user
  end

  def destroy
    @user.destroy

    render json: @user
  end

  private

  def get_user
    @user = User.find(params[:id])
  rescue
    render nothing: true
  end
end
