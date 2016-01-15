class FriendshipsController < ApplicationController
  
  def index
  end

  def new
  end

  def create
    # take current user model and build a friendship through it
    # call friend id and pass in friend id parameter from url which is passed in from the previous request
    # friend_id from previous request is the friend_id  you use to build the friendship
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Successfully created friendship."
      redirect_to root_path
    else
      # need to update the error message
      flash[:error] = "unable to add friend."
      redirect_to root_path
  end

  def edit
  end

  def show
  end

  def update
    # patch/put method on from the edit page
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Successfully destroyed friendship."
    # current_user page is the profile page
    redirect_to current_user
  end
end
