class BookmarksController < ApplicationController

  def index
    @bookmarks = current_user.bookmarks
    @bookmark = Bookmark.new
    @user = User.find_by_id params[:user_id]
  end

  def create
    @bookmark = Bookmark.new bookmark_params
    @bookmark.user_id = current_user.id
    if @bookmark.save
      render :json => { "success": 200 }
    else
      flash.now[:error] = "Bookmark was not created, try again!"
      render :json => { "failures": 200 }
    end
  end

  # need this show page?
  # def show
  # end

  def edit
    @bookmark = Bookmark.find(params[:id])
    # renders edit page
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.update(bookmark_params)
      redirect_to index_path, flash: {}
    else
      render json: {errors: @bookmark.errors.full_messages}
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
      flash[:notice] = "successfully deleted!"
      format.js {
        # in js file just remove the selected element
      }
    else
      render
    end

    # # success below?
    # render json: {}
    redirect_to user_bookmarks_path(current_user.id)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:title, :image, :description, :location, :date, :time, :url)
  end

end
