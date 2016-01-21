class BookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks
    @bookmark = Bookmark.new
    # bookmarks page will have a form to create a new bookmark and 
    # then reload all bookmarks without refreshing so ajax
  end

  def create
    @bookmark = Bookmark.new bookmark_params
    if @bookmark.save
      render json: @bookmark
    else 
      render json: {errors: @bookmark.errors.full_messages}
    end
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
      params.require(:bookmark).permit(:title, :image, :description, :location, :date, :time, :url)
    end
  end

end
