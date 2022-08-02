# frozen_string_literal: true

class ContactSerializer
  include JSONAPI::Serializer
  attributes :email, :name, :phone

  belongs_to :user
end
