# frozen_string_literal: true

module Api
  module V1
    class SlidesController < ApplicationController
      def create
        @slide = Slide.new(slide_params)
        if !integer?(params[:name]) && @slide.save
        render json: SlideSerializer.new(@slide).serializable_hash.to_json
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

      private

      def slide_params
        params.permit(:image_url, :text, :order, :organization_id)
      end

      def set_slide
        @slide = slide.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Could not find member with ID '#{params[:id]}'" }
      end

      def integer?(prmtrs)
        prmtrs.to_i.to_s == prmtrs
      end
      
    end
  end
end
