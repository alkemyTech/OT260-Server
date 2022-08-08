# frozen_string_literal: true

module Api
  module V1
    class ContactsController < ApplicationController
      before_action :authenticate_request, only: %i[index create]

      def index
        @contact = @current_user.contacts.all
        render json: ContactSerializer.new(@contact).serializable_hash, status: :ok
      end

      def create
        @contact = Contact.new(contact_params)
        @contact.user = @current_user
        if @contact.save
          Sendeable.contact_notification_email(@contact, 'Gracias por Registrarse en Somos Más')
          render json: ContactSerializer.new(@contact).serializable_hash, status: :created
        else
          render_error
        end
      end

      private

      def contact_params
        params.require(:contact).permit(:email, :name, :message, :phone)
      end

      def render_error
        render json: { errors: @contact.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  end
end
