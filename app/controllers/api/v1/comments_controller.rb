# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_request, only: %i[index create update destroy]
      before_action :set_comment, only: %i[update destroy]
      before_action :authorize_user, only: %i[create update destroy]

      def index
        @comment = Comment.order('created_at DESC')
        render json: CommentSerializer.new(@comment,
                                           fields: { comment: :body })
                                      .serializable_hash, status: :ok
      end

      def create
        @comment = Comment.new(comment_params)
        @comment.user_id = @current_user.id
        if @comment.save
          render json: CommentSerializer.new(@comment).serializable_hash, status: :created
        else
          render_error
        end
      end

      def update
        if ownership?
          @comment = Comment.update(comment_params)
          render json: CommentSerializer.new(@comment).serializable_hash
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if ownership?
          @comment.discard
          head :no_content
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end

      private

      def set_comment
        @comment = Comment.find(params[:id])
      end

      def comment_params
        params.require(:comment).permit(:body, :news_id)
      end

      def render_error
        render json: { errors: @comment.errors.full_messages },
               status: :unprocessable_entity
      end

      def render_unauthorized
        render status: :unauthorized, json: {
          errors: [I18n.t('errors.controllers.unauthorized')]
        }
      end
    end
  end
end
