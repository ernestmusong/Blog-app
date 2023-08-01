module Api
  module V1
    class CommentsController < ApplicationController
      def index
        @post = Post.find(params[:post_id])
        @comments = @post.comments.includes(:author)

        render json: @comments
      end

      def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.new(comment_params)
        @comment.author = current_user

        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end
    end
  end
end
