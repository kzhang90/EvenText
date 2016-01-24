class UsersController < ApplicationController
 
  def index
    @users = User.all
    # these are all of the users. 
    # separate link or no?
    # if it's my own profile that I click on, I can view everything, MANAGE PERMISSIONS!!
  end

  def show
    @user = current_user
    # THIS IS ANOTHER USER'S PROFILE
    # if you're the right user you can see the users. if not, you only see their pic and basic info
  end
end
