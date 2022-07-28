# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_request, only: %i[create]

      def index
        @comment = Comment.all.order('created_at DESC')
        render json: CommentsSerializer.new(@comment).serializable_hash.to_json
      end

      def create
        @comment = Comment.new(comment_params)
        if @comment.save
          render json: CommentsSerializer.new(@comment).serializable_hash, status: :created
        else
          render_error
        end
      end

      private

      def comment_params
        params.require(:comment).permit(:body, :user_id, :news_id)
      end

      def render_error
        render json: { errors: @comment.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  end
end
