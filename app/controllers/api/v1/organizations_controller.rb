# frozen_string_literal: true

module Api
  module V1
    class OrganizationsController < ApplicationController
      before_action :set_organization
      before_action :authenticate_request, only: :public

      def public
        render json: OrganizationSerializer.new(@organization,
                                                fields: { organization:
                                                %i[
                                                  name
                                                  image
                                                  phone
                                                  address
                                                  facebook_url
                                                  instagram_url
                                                  linkedin_url
                                                ] })
                                           .serializable_hash, status: :ok
      end

      private

      def set_organization
        @organization = Organization.kept.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Could not find organization with ID '#{params[:id]}'" },
               status: :unprocessable_entity
      end
    end
  end
end
