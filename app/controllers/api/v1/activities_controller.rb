# frozen_string_literal: true

module Api
  module V1
    class ActivitiesController < ApplicationController
      before_action :authenticate_request, only: %i[create update]
      before_action :authorize_user, only: %i[create update]
      before_action :set_activity, only: %i[update]

      def create
        @activity = Activity.new(activity_params)
        if @activity.save
          render json: ActivitySerializer.new(@activity).serializable_hash.to_json, status: :created
        else
          render json: @activity.errors, status: :unprocessable_entity
        end
      end

      def update
        if @activity.update(activity_params)
          render json: ActivitySerializer.new(@activity).serializable_hash.to_json, status: :ok
        else
          render json: @activity.errors, status: :unprocessable_entity
        end
      end

      private

      def set_activity
        @activity = Activity.kept.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Couldn't find activity with ID #{params[:id]}" }, status: :not_found
      end

      def activity_params
        params.require(:activity).permit(:name, :content, :image)
      end
    end
  end
end
