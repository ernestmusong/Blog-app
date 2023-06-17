class LikesController < ApplicationController
  before_action :set_post, only: %i[create destroy]

  def create
    @like = @post.likes.build(author: current_user)
    if @like.save
      redirect_to user_post_path(user_id: current_user.id, id: @post.id), notice: 'Post liked!'
    else
      redirect_to user_post_path(user_id: current_user.id, id: @post.id), alert: 'Sorry, there was an error.'
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_to user_post_path(user_id: current_user.id, id: @post.id), notice: 'Post unliked!'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
