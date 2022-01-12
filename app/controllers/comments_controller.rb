class CommentsController < ApplicationController

  def create
      @micropost = Micropost.find(params[:micropost])
      @comment = @micropost.comments.create(params[:comment].permit(:username, :comment))
      redirect_to current_user
  end

  def destroy
      @micropost = Micropost.find(params[:micropost_id])
      @comment = @micropost.comments.find(params[:id])
      @comment.destroy
      redirect_to current_user
  end

  def current_user?(user)
    user == current_user
  end

end
