# frozen_string_literal: true

module Api
  module V1
    class MembersController < ApplicationController
      before_action :authenticate_request, only: %i[index]
      before_action :authorize_user, only: %i[index]

      def index
        @members = Member.kept
        render json: MembersSerializer.new(@members).serializable_hash.to_json
      end
    end
  end
end
