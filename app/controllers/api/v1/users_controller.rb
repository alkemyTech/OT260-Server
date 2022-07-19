# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :fetch_user_by_email, only: [:login]

      def fetch_user_by_email
        @user = User.find_by(email: params[:user][:email])
      end

      def login
        if @user&.authenticate(params[:user][:password])
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.zone.now + 24.hours.to_i
          render json: { token: token, exp: time.strftime('%m-%d-%Y %H:%M'),
                         username: @user.first_name }, status: :ok
        else
          render json: { ok: false }
        end
      end

      private

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end
