# frozen_string_literal: true

module Api
  module V1
    class TestimonialsController < ApplicationController
      before_action :authenticate_request, only: %i[create update destroy]
      before_action :authorize_user, only: %i[create update destroy]
      before_action :set_testimonial, only: %i[update destroy]
      after_action { pagy_headers_merge(@pagy) if @pagy }
      include Pagy::Backend

      def index
        @pagy, @testimonials = pagy(Category.kept)
        render json: TestimonialSerializer.new(@testimonials).serializable_hash, status: :ok
      end

      def create
        @testimonial = Testimonial.new(testimonial_params)
        if @testimonial.save
          render json: TestimonialSerializer.new(@testimonial).serializable_hash, status: :created
        end
      end

      def update
        if @testimonial.update(testimonial_params)
          render json: TestimonialSerializer.new(@testimonial).serializable_hash, status: :ok
        else
          render json: @testimonial.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @testimonial.discard
        head :no_content
      end

      private

      def set_testimonial
        @testimonial = Testimonial.kept.find(params[:id])
      end

      def testimonial_params
        params.require(:testimonial).permit(:image, :name, :content)
      end
    end
  end
end
