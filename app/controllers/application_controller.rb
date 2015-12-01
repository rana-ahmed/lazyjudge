class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/404.html", :status => 404
  end

  private
  def current_user
    @current_user ||= User.where(id: session[:user_id]).take if session[:user_id]
    #if admin remove the team
    session[:user_type] = nil if @current_user.nil?
    @current_user
  end
  helper_method :current_user

  def login_required
    redirect_to root_path if current_user.nil?
  end

  def contest_not_running
    redirect_to :back, notice: "Contest is not running" if Setting.contest_running.nil?
  end
end
