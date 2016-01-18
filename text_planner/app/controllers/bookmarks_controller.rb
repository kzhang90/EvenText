class BookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks
    # redirected here after user clicks link to bookmarks index path
  end

  def create
    @bookmark = Bookmark.new bookmark_params
  end

  def new
    # make new bookmarks in bookmarks index
    :index 
  end

  def edit
    # @bookmark = Bookmark.find(params[:id])

  end

  def show
    @bookmark = Bookmark.find(params[:id])
    # @new_comment = @bookmark.comments.build
  end

  def update
  end

  def destroy
  end

  private

    def bookmark_params
      params.require(:bookmark).permit(:)
    end
  end

end
