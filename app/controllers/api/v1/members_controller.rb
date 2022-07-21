# frozen_string_literal: true

module Api
  module V1
    class MembersController < ApplicationController
      before_action :authenticate_request, only: %i[index create update destroy]
      before_action :authorize_user, only: %i[index]
      before_action :set_member, only: %i[update destroy]

      def index
        @members = Member.kept
        render json: MembersSerializer.new(@members).serializable_hash, status: :ok
      end

      def create
        if category_params[:name].to_i.to_s == '0'
          @member = Member.new(member_params)
          if @member.save
            render json: MemberSerializer.new(@member).serializable_hash, status: :created
          else
            render json: @member.errors, status: :unprocessable_entity
          end
        else
          render json: { error: 'Name parameter is not a Sting' }, status: :unprocessable_entity
        end
      end

      def update
        if @member.update(member_params)
          render json: MemberSerializer.new(@member).serializable_hash, status: :ok
        else
          render json: @member.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @member.discard
        head :no_content
      end

      private

      def set_member
        @member = Member.kept.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Could not find member with ID '#{params[:id]}'" }
      end

      def member_params
        params.permit(:name, :description, :facebook_url, :instagram_url, :linkedin_url)
      end
    end
  end
end
