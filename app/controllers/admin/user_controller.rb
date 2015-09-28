class Admin::UserController < ApplicationController
  def index
    @users = User.all
  end

  def create

  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_user_index_path
  end
end
