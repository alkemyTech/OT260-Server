# frozen_string_literal: true

module Api
  module V1
    class TestimonialsController < ApplicationController
      before_action :authenticate_request, only: %i[create]
      before_action :authorize_user, only: %i[create]

      def create
        @testimonial = Testimonial.new(testimonial_params)
        if @testimonial.save
          render json: TestimonialSerializer.new(@testimonial).serializable_hash, status: :created
        else
          render json: @testimonial.errors, status: :unprocessable_entity
        end
      end

      private

      def testimonial_params
        params.require(:testimonial).permit(:image, :name, :content)
      end
    end
  end
end
