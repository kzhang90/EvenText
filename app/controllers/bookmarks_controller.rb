class BookmarksController < ApplicationController

  def index
    @bookmarks = current_user.bookmarks.order('id DESC')
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new bookmark_params
    @bookmark.user_id = current_user.id
    if @bookmark.save
      flash.now[:success] = "Bookmark created successfully!"
      render json: @bookmark
    else
      flash.now[:error] = "Bookmark was not created, try again!"
      render status: 500
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update(bookmark_params)
      flash[:success] = "Successfully updated bookmark!"
      redirect_to user_bookmarks_path(current_user)
    else
      render json: {errors: @bookmark.errors.full_messages}
    end
  end

  def show
    @user = current_user
    @reminder = Reminder.new
    @bookmark = Bookmark.find(params[:id])
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
      flash[:notice] = "Bookmark Deleted!"
      redirect_to user_bookmarks_path(current_user)
    else
      render json: {errors: @bookmark.errors.full_messages} 
    end
  end


  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :image, :description, :location, :date, :time, :url)
  end

end
