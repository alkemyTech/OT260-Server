# frozen_string_literal: true

require 'json_web_token'

module Api
  module V1
    class AuthenticationController < ApplicationController
      before_action :authorize_request, except: :login

      def login
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: @user.id)
          time = Time.zone.now + 24.hours.to_i
          render json: { token: token, exp: time.strftime('%m-%d-%Y %H:%M'),
                         username: @user.first_name }, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end

      private

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end
