# frozen_string_literal: true

module Api
  module V1
    class NewsController < ApplicationController
      before_action :set_news, only: %i[show update destroy]
      before_action :authenticate_request, only: %i[show create update destroy]
      before_action :authorize_user, only: %i[show create update destroy]

      def show
        render json: NewsSerializer.new(@news).serializable_hash
      end

      def create
        @news = News.new(news_params)
        @news.category = Category.find(params[:news][:category_id])
        return unless @news.save

        render json: NewsSerializer.new(@news)
                                   .serializable_hash, status: :created
      end

      def update
        @news.update(news_params)
        render json: NewsSerializer.new(@news).serializable_hash
      end

      def destroy
        @news.discard
        head :no_content
      end

      private

      def set_news
        @news = News.kept.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Could not find news with ID '#{params[:id]}'" }
      end

      def news_params
        params.require(:news).permit(:content, :image, :name, :news_type)
      end
    end
  end
end
