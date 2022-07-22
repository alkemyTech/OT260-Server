# frozen_string_literal: true

module Api
  module V1
    class SlidesController < ApplicationController
      before_actio _set_slide, only: %i[destroy]

      def destroy
        @slide.discard
        head :no_content
      end

      private

      def set_slide
        @slide = Slide.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Could not find member with ID '#{params[:id]}'" }
      end
    end
  end
end
