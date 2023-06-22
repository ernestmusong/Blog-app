class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(user_id: current_user.id, id: @post.id)
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to user_post_path(user_id: current_user.id, id: @post.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
