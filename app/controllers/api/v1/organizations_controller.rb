# frozen_string_literal: true

module Api
  module V1
    class OrganizationsController < ApplicationController
      before_action :authorization
      before_action :set_organization, only: %i[update]
      before_action :admin?, only: %i[update]

      # GET /organization/:id/public

      def public
        @organization = Organization.find(params[:id])
        render json: OrganizationSerializer.new(@organization).serializable_hash.to_json
      end

      # POST /organization/

      def create
        @organization = Organization.new(organization_params)
        if @organization.save
          render json: OrganizationSerializer.new(@organization).serializable_hash.to_json,
                 status: :created
        else
          render json: { errors: @organization }, status: :unprocessable_entity
        end
      end

      # PUT /organization/:id/public

      def update
        if @organization.update(params.require(:name, :image, :phone, :address))
          render json: OrganizationSerializer.new(@organization).serializable_hash.to_json
        else
          render json: { errors: @organization }, status: :unprocessable_entity
        end
      end

      private

      def organization_params
        params.permit(:about_us_text, :address, :email, :name, :phone, :welcome_text, :image)
      end

      def set_organization
        @organization = Organization.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Could not find organization with ID '#{params[:id]}'" },
               status: :unprocessable_entity
      end
    end
  end
end
