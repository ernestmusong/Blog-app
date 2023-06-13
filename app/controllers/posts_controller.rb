class PostsController < ApplicationController
  def index; end
  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end
end
