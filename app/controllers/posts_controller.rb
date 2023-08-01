class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource # This line will automatically authorize each action based on the Ability class

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:author, :comments)

    respond_to do |format|
      format.html { render :index }
    end
  end

  def show
    @post = @user.posts.includes(:author, :comments).find(params[:id])
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

  def destroy
    @post.comments.destroy_all
    @post.likes.destroy_all
    @post.destroy

    redirect_to user_posts_path(user_id: @user.id)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
