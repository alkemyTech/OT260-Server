# frozen_string_literal: true

require 'json_web_token'

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_request, except: :create

      def create
        @user = User.new(user_params)
        if @user.save
          token = JsonWebToken.encode(user_id: @user)
          render json: {
            user: UserSerializer.new(@user).serializable_hash,
            token: token
          }, status: :created
        else
          render_error
        end
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :photo,
                                     :role_id)
      end

      def render_error
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  end
end
