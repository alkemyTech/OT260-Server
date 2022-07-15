# frozen_string_literal: true

module Api
  module V1
    class OrganizationsController < ApplicationController
      before_action :authorization

      # GET /organization_id/public

      def public
        @organization = Organization.find(params[:id])
        render json: OrganizationSerializer.new(@organization).serializable_hash.to_json
      end
    end
  end
end
