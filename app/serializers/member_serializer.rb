# frozen_string_literal: true

# == Schema Information
#
# Table name: members
#
#  id            :bigint           not null, primary key
#  description   :string
#  discarded_at  :datetime
#  facebook_url  :string
#  instagram_url :string
#  linkedin_url  :string
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_members_on_discarded_at  (discarded_at)
#
class MemberSerializer
  include JSONAPI::Serializer

  attributes :description, :name, :facebook_url, :instagram_url, :linkedin_url
end
