class UsersController < ApplicationController
  def index
    # show all users, admin only?
    @users = User.all
  end

  def show
    @user = current_user
  end

  def create
  end
  
end
