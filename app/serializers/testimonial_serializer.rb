# frozen_string_literal: true

class TestimonialSerializer
  include JSONAPI::Serializer
  attributes :name, :content
  attribute :image do |object|
    object.image.url if object.image.filename
  end
end
