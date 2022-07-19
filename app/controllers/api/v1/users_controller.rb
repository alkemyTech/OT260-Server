# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def login
        @user = User.find_by(email: params[:user][:email])

        if @user&.authenticate(params[:password])
          render json: @user
        else
          render json: { ok: false }
        end
      end
    end
  end
end
