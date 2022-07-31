# frozen_string_literal: true

module Api
  module V1
    class SlidesController < ApplicationController
      before_action :authenticate_request, only: %i[show create update destroy]
      before_action :authorize_user, only: %i[show create update destroy]
      before_action :set_slide, only: %i[show update destroy]

      def show
        if @slide
          render json: SlideSerializer.new(@slide).serializable_hash.to_json, status: :ok
        else
          render_error
        end
      end

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

      def update
        if @slide.update(slide_params)
          render json: SlideSerializer.new(@slide).serializable_hash.to_json, status: :ok
        else
          render json: @slide.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @slide.destroy
        head :no_content
      end

      private

      def set_slide
        @slide = Slide.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Could not find member with ID '#{params[:id]}'" }
      end

      def slide_params
        params.require(:slide).permit(:text, :order, :image)
      end

      def render_error
        render json: { errors: @slide.errors.full_messages }, status: :not_found
      end
    end
  end
end
