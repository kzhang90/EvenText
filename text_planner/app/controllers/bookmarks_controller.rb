class BookmarksController < ApplicationController

  def index
    @bookmarks = current_user.bookmarks
    @bookmark = Bookmark.new
    @user = User.find_by_id params[:user_id]
  end

  def create
    @bookmark = Bookmark.new bookmark_params
    @bookmark.user_id = current_user.id

    respond_to do |format|
      if @bookmark.save
        format.html { 
          redirect_to user_bookmarks_path,
          notice: 'Bookmark was successfully created.'
        }
        format.json { 
          render json: @bookmark,
          status: :created, 
          location: @bookmark
        }
        format.js {}
      else 
        format.html {
          render :index
        }
        format.json {
          render json: @bookmark.errors.full_messages
        }
        format.js {}
      end
    end
  end

  def edit 
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.user_id = current_user.id

    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        format.html {
          redirect_to user_bookmarks_path,
          notice: 'Bookmark has been successfully updated.'
        }
        format.json {
          render json: @bookmark
        }
      else
        # debug this
        format.html {
          redirect_to edit_bookmarks_path,
          notice: 'Bookmark could not be updated. Please try again.'
        }
        format.json {
          render json: @bookmark.errors.full_messages
        }
      end
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    respond_to do |format|
      if @bookmark.destroy
        format.html {
          redirect_to user_bookmarks_path(current_user.id),
          notice: 'Bookmark has been successfully deleted.'
        }
        format.js {}    
      else
        format.html {
          redirect_to user_bookmarks_path(current_user.id),
          error: 'Bookmark could not be deleted.'
        }
        format.js {}
      end
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :image, :description, :location, :date, :time, :url)
  end

end
