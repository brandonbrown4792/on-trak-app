class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find_by(username: params[:username])
  end
end
