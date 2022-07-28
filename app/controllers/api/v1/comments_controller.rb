# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_request, only: %i[index create update]
      before_action :set_comment, only: %i[update]

      def index
        @comment = Comment.order('created_at DESC')
        render json: CommentsSerializer.new(@comment,
                                            fields: { comments: :body })
                                       .serializable_hash.to_json
      end

      def create
        @comment = Comment.new(comment_params)
        @comment.user = @current_user
        @comment.news = @current_user.news.find(params[:news_id])
        if @comment.save
          render json: CommentsSerializer.new(@comment).serializable_hash, status: :created
        else
          render_error
        end
      end

      def update
        if @current_user.id == @comment.user_id || admin?
          @comment = Comment.update(comment_params)
          render json: CommentsSerializer.new(@comment).serializable_hash
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
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
