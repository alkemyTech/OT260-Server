# frozen_string_literal: true

module Api
  module V1
    class ContactsController < ApplicationController
      def index
        @contact = Contact.all
        render json: ContactSerializer.new(@contact).serializable_hash
      end
    end

    def create
      @contact = Contact.new(contact_params)
      if @contact.save
        send_mail
        render json: ContactSerializer.new(@contact).serializable_hash, status: :created
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end

    private

    def contact_params
      params.require(:contact).permit(:name, :phone, :email, :message)
    end

    def render_error
      render json: { errors: @contact.errors.full_messages }, status: :not_found
    end
  end
end
