# frozen_string_literal: true

module Api
  module V1
    class ContactsController < ApplicationController
      before_action :authenticate_request, only: %i[index]

      def index
        @contact = @current_user.contacts.all
        render json: ContactSerializer.new(@contact).serializable_hash
      end
    end
  end
end
