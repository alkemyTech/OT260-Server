# frozen_string_literal: true

module Api
  module V1
    class SlidesController < ApplicationController
      before_action :authenticate_request, only: %i[create]
      before_action :authorize_user, only: %i[create]

      def create
        @slide = Slide.new(slide_params)
        @slide.order = Slide.all.pluck(:order).max + 1 if @slide.order.nil?
        @slide.organization = Organization.find(params[:organization_id])
        if @slide.save
          render json: SlideSerializer.new(@slide).serializable_hash, status: :ok
        else
          render json: @slide.errors, status: :unprocessable_entity
        end
      end

      private

      def slide_params
        params.require(:slide).permit(:text, :order, :image)
      end

      def render_error
        render json: { errors: @slide.errors.full_messages }, status: :not_found
      end
    end
  end
end
