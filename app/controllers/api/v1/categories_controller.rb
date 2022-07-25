# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :authorize_request, only: [:create]

      def create
        if category_params[:name].to_i.to_s == '0'
          @category = Category.new(category_params)

          if @category.save
            render json: CategorySerializer.new(@category).serializable_hash, status: :created
          else
            render json: @category.errors, status: :unprocessable_entity
          end
        else
          render json: { error: 'Name parameter is not a Sting' }, status: :unprocessable_entity
        end
      end

      private

      def category_params
        params.require(:category).permit(:name, :description)
      end
    end
  end
end
