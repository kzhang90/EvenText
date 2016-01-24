class BookmarksController < ApplicationController

  def index
    @bookmarks = current_user.bookmarks
    @bookmark = Bookmark.new
    @user = User.find_by_id params[:user_id]
  end

  def create
    @bookmark = Bookmark.new bookmark_params
    @bookmark.user_id = current_user.id

# flash sticks around for the next one. flash.now will 

    respond_to do |format|
      if @bookmark.save
        flash.now[:success] = 'Bookmark was created successfully!'
        format.html { 
          redirect_to user_bookmarks_path
        }
        format.json { 
          render json: @bookmark
        }
        # when theres an ajax call, the flash messages aren't appending.
        format.js {}
      else
        flash.now[:notice] = "Bookmark could not be created. Please try again."
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

  def show
    @user = current_user
    @reminder = Reminder.new
    @bookmark = Bookmark.find(params[:id])
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    # add error handling in update bookmark
    @bookmark = Bookmark.find(params[:id])
    @bookmark.user_id = current_user.id

    respond_to do |format|

      if @bookmark.update_attributes(bookmark_params)
        flash[:success]= 'Bookmark has been successfully updated.'
        format.html {
          redirect_to user_bookmarks_path(current_user.id)
        }
        format.json {
          render json: @bookmark
        }
      else
        # debug this
        flash[:error] = 'Bookmark could not be updated. Please try again.'
        format.html {
          redirect_to edit_bookmarks_path
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
        # WORKING.
        # since it redirects the page, use flash
        flash[:success]='Bookmark has been successfully deleted.'
        format.html {
          redirect_to user_bookmarks_path(current_user.id)
        }   
      else
        flash[:error]='Bookmark could not be deleted.'
        format.html {
          redirect_to user_bookmarks_path(current_user.id)
        }
      end

    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :image, :description, :location, :date, :time, :url)
  end

end
