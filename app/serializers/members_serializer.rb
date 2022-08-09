# frozen_string_literal: true

class MembersSerializer
  include JSONAPI::Serializer

  attributes :name, :description, :facebook_url, :instagram_url, :linkedin_url
  attributes :image do |member|
    member.image.service_url if member.image.attached?
  end
end
