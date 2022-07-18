# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        @user = User.new(user_params)
        if @user.save
          render json: UserSerializer.new(@user).serializable_hash.to_json, status: :created
        else
          render_error
        end
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password_digest, :photo,
                                     :role_id)
      end

      def render_error
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  end
end
