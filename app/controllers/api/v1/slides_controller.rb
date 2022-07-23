module Api
    module V1
      class SlidesController < ApplicationController
        def create
          @slide = Slide.new(slide_params)
          if @slide.save
            render json: SlideSerializer.new(@slider).serializable_hash.to_json
          else
            render json: @slider.errors, status: :unprocessable_entity
          end
        end
  
        private
  
        def slide_params
          params.require(:slide).permit(:image_url, :text, :order)
        end

      end
    end
  end