# frozen_string_literal: true

module Api
  module V1
    class OrganizationsController < ApplicationController
      before_action :set_organization
      before_action :authorize_request, only: :public

      def public
        render json: OrganizationSerializer.new(@organization,
                                                fields: { organization:
                                                %i[
                                                  name
                                                  image
                                                  phone
                                                  address
                                                ] })
                                           .serializable_hash, status: :ok
      end

      private

      def set_organization
        @organization = Organization.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Could not find organization with ID '#{params[:id]}'" },
               status: :unprocessable_entity
      end
    end
  end
end
