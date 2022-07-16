# frozen_string_literal: true

module Api
  module V1
    class NewsController < ApplicationController
      before_action :set_news, only: %i[show]
      before_action :authenticate_request, only: %i[show create]
      before_action :authorize_user, only: %i[show create]

      def show
        render json: NewsSerializer.new(@news).serializable_hash
      end

      def create
        @news = News.new(news_params)
        @news.category = Category.find(params[:news][:category_id])
        if @news.save
          render json: NewsSerializer.new(@news).serializable_hash,
                 status: :created
        else
          render json: { errors: @news }, status: :unprocessable_entity
        end
      end

      private

      def set_news
        @news = News.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Could not find news with ID '#{params[:id]}'" }
      end

      def news_params
        params.require(:news).permit(:content, :image, :name, :news_type)
      end
    end
  end
end
