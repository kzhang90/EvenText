class BookmarksController < ApplicationController

  def index
    @bookmarks = current_user.bookmarks
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new bookmark_params
    respond_to do |format|
      flash[:success] = "Bookmark added!"
      flash[:error] = "Bookmark not created!"
      if @bookmark.save
        format.html { render :index }
        # format.js {}
        format.json { flash[:success] }
      else 
        format.html { render :index }
        format.json { flash [:error]}
      end
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
    params.require(:bookmark).permit(:title, :image, :description, :date, :time, :url)
  end

end
