# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :admin?, only: %i[update]

      # PUT /categories/:id

      def update
        if @category.update(category_params)
          render json: CategorySerializer.new(@category).serializable_hash.to_json
        else
          render json: { errors: @category }, status: :unprocessable_entity
        end
      end

      private

      def set_category
        @category = Category.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Could not find category with ID '#{params[:id]}'" },
               status: :unprocessable_entity
      end
    end
  end
end
