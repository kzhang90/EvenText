class BookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks
    # redirected here after user clicks link to bookmarks index path
  end

  def create
    @bookmark = Bookmark.build
  end

  def new
    # people can make new bookmarks in the
  end

  def edit
  end

  def show
    @bookmark = Bookmark.find(params[:id])
    # @new_comment = @bookmark.comments.build
  end

  def update
  end

  def destroy
  end

end
