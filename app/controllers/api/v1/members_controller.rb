# frozen_string_literal: true

module Api
  module V1
    class MembersController < ApplicationController
      before_action :authenticate_request, only: %i[index create]
      before_action :authorize_user, only: %i[index]

      def index
        @members = Member.kept
        render json: MembersSerializer.new(@members).serializable_hash.to_json
      end

      def create
        if category_params[:name].to_i.to_s == '0'
          @member = Member.new(member_params)
          if @member.save
            render json: MemberSerializer.new(@member).serializable_hash.to_json
          else
            render json: @member.errors, status: :unprocessable_entity
          end
        else
          render json: { error: 'Name parameter is not a Sting' }, status: :unprocessable_entity
        end
      end

      private

      def member_params
        params.permit(:name, :description, :facebook_url, :instagram_url, :linkedin_url)
      end
    end
  end
end
