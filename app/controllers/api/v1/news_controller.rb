# frozen_string_literal: true

module Api
  module V1
    class NewsController < ApplicationController
      before_action :authenticate_request, only: %i[create]
      before_action :authorize_user, only: %i[create]

      def create
        @news = News.new(news_params)
        @news.category = Category.find(params[:news][:category_id])
        if @news.save
          render json: NewsSerializer.new(@news).serializable_hash.to_json,
                 status: :created
        else
          render json: { errors: @news }, status: :unprocessable_entity
        end
      end

      private

      def news_params
        params.require(:news).permit(:content, :image, :name, :news_type)
      end
    end
  end
end
