class FriendshipsController < ApplicationController
  
  def index
    # show all of my friends
  end

  def create
    # take current user model and build a friendship through it
    # call friend id and pass in friend id parameter from url which is passed in from the previous request
    # friend_id from previous request is the friend_id  you use to build the friendship
    @friendship = current_user.friendships.build(:friend_id => params[:user_id])
    if @friendship.save
      flash[:notice] = "Added friend successfully."
      # redirect_to profile page
      redirect_to current_user
    else
      flash[:error] = "Unable to add friend."
      # redirect to where?
      redirect_to current_user
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Successfully destroyed friendship."
    # current_user page is the profile page
    redirect_to current_user
  end
  
end
