# frozen_string_literal: true

class OrganizationSerializer
  include JSONAPI::Serializer
  attributes :name, :phone, :address
  attribute :image do |organization|
    if organization.image.attached?
      Rails.application.routes.url_helpers.rails_blob_path(organization.image,
                                                           only_path: true)
    end
  end
end
