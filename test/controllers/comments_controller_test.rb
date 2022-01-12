require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest

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

end
