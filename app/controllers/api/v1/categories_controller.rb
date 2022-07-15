# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :authorization

      # GET /category_id/public

      def public
        @category = Category.find(params[:id])
      end
    end
  end
end
