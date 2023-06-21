class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:author, :comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.includes(:author, :comments).find(params[:id])
    @comment = @post.comments.new
  end

  def new
    @post = Post.new(author: current_user)
    respond_to do |format|
      format.html { render :new, locals: { post: @post } }
    end
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path(user_id: current_user.id)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
