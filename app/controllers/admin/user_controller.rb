class Admin::UserController < ApplicationController
  def index
    @users = User.all
  end

  def create

  end

  def delete

  end
end
