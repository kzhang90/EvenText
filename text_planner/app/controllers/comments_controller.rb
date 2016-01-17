class CommentsController < ApplicationController
  def index
    @comments = Comment.find(params[:bookmark_id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end
end
