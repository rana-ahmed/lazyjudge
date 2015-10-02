class SessionsController < ApplicationController
  def create
    user = User.find_by_user_name(user_parms[:user_name])
    if user && user.authenticate(user_parms[:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in!"
      flash[:type] = "alert-success"
      #here we will call current_user_root
      redirect_to root_url
    else
      flash[:notice] = "User name or password invalid"
      flash[:type] = "alert-warning"
      redirect_to :back
    end
  end

  def destroy
    if current_user
      session[:user_id] = nil
      redirect_to root_url, notice: "Logged out!"
    else
      flash[:notice] = "Logged in first"
      flash[:type] = "alert-warning"
      redirect_to root_url
    end
  end

  private
  def user_parms
    params.require(:user).permit(:user_name, :password)
  end
end
