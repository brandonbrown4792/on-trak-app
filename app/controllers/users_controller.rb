class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy, :groups]

  def show
    @lists = @user.sort_lists
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
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to edit_user_path(current_user)
    end
  end

  def destroy
    @user.delete_account
    session[:user_id] = nil
    redirect_to '/'
  end

  def groups
  end

  private

  def user_params
    params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
  end

  def find_user
    if params[:username]
      @user = User.find_by(username: params[:username])
    end
    if params[:user_username]
      @user = User.find_by(username: params[:user_username])
    end
  end
end
