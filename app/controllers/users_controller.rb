class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = Post
    @posts = @user.posts.limit(3)
  end

  def destroy
    @user = User.find(params[:id])
    @user.posts.destroy_all
    @user.destroy
    redirect_to users_path, notice: 'User deleted successfully.'
  end

  def sign_out_user
    sign_out current_user
    redirect_to root_path
  end
end
