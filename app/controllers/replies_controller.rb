class RepliesController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:comment_id])
    @reply = Reply.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:comment_id])
    @reply = @comment.replies.new(reply_params)
    @reply.author = current_user
    if @reply.save
      flash[:success] = 'Reply created successfully'
      redirect_to user_post_path(user_id: current_user.id, id: @post.id)
    else
      render :new
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:text)
  end
end
