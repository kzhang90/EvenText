class BookmarksController < ApplicationController

  def index
    @bookmarks = current_user.bookmarks
    @bookmark = Bookmark.new
    @user = User.find_by_id params[:user_id]
  end

  def create
    @bookmark = Bookmark.new bookmark_params
    @bookmark.user_id = current_user.id
    # flash[:success] = "Bookmark added!"
    # flash[:error] = "Bookmark not created!"
    respond_to do |format|
      if @bookmark.save
        # saving from html page
        format.html { 
          flash[:success] = "Bookmark successfully created!"
          redirect :index 
        }
        # ajax request coming from application index page
        # and bookmark index page. how to handle that?
        format.js {}
      else 
        format.html { 
          flash.now[:error] = "Bookmark was not created, try again!"
          render :index
        }
        format.json {
        }
      end
    end
  end

  def edit 
    @bookmark = Bookmark.find(params[:id])
    # renders edit page
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update(bookmark_params)
      render json: @bookmark
    else
      render json: {errors: @bookmark.errors.full_messages}
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    # success below?
    render json: {}
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :image, :description, :date, :time, :url)
  end

end
