class BookmarksController < ApplicationController
  def index
    
    # redirected here after user clicks link to bookmarks index path

  end

  def create
    @bookmark = Bookmark.new()
  end

  def new
  end

  def edit
  end

  def show
    @bookmarks = Bookmark.find(params[:id])
  end

  def update
  end

  def destroy
  end

end
