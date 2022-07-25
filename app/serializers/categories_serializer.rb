# frozen_string_literal: true

class CategoriesSerializer
  include JSONAPI::Serializer
  attributes :name, :description
end
