class Admin::UsersController < ApplicationController
  def index
    @users = User.order(:role, user_name: :asc).all
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      @users = User.order(:role, user_name: :asc).all
      render :index
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password_digest, :role)
  end
end
