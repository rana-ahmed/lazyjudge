class SessionsController < ApplicationController
  before_filter :login_required, only: [:destroy]

  def create
    user = User.find_by_user_name(user_parms[:user_name])
    if user && user.authenticate(user_parms[:password])
      session[:user_id] = user.id
      session[:user_type] = user.role
      flash[:notice] = "Logged in!"
      flash[:type] = "alert-success"
      redirect_to root_url
    else
      flash[:notice] = "User name or password invalid"
      flash[:type] = "alert-warning"
      redirect_to :back
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    redirect_to root_url, notice: "Logged out!"
  end

  private
  def user_parms
    params.require(:user).permit(:user_name, :password)
  end
end
