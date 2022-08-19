# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_request, only: %i[index create update destroy]
      before_action :authorize_user, only: %i[index]
      before_action :ownership?, only: %i[update destroy]
      before_action :set_comment, only: %i[update destroy]

      def index
        if params[:news_id]
          @news = News.find(params[:news_id])
          @comments = @news.comments
          render json: CommentSerializer.new(@comments).serializable_hash
        else
          @comments = Comment.order('created_at DESC')
          render json: CommentSerializer.new(@comments,
                                             fields: { comments: :body })
                                        .serializable_hash, status: :ok
        end
      end

      def create
        @comment = Comment.new(comment_params)
        @comment.user = @current_user
        @comment.news = News.find(params[:news_id])
        if @comment.save
          render json: CommentSerializer.new(@comment).serializable_hash, status: :created
        else
          render_error
        end
      end

      def update
        if @comment.update(comment_params)
          render json: CommentSerializer.new(@comment).serializable_hash, status: :ok
        else
          render_error
        end
      end

      def destroy
        @comment.destroy
        head :no_content
      end

      private

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:body)
      end

      def render_error
        render json: { errors: @comment.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  end
end
