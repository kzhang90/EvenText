class CommentsController < ApplicationController
  def index
    @bookmark = Bookmark.find params[:bookmark_id]
    @comment = @bookmark.comments.new
  end

  def create
    @bookmark = Bookmark.find params[:bookmark_id]
    @comment = @bookmark.comments.new bookmark_params
    @comment.user = current_user
    @comment.save
  end

  def show
  end

  def update
  end

  def destroy
  end
end
