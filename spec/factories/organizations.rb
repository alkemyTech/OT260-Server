# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id            :bigint           not null, primary key
#  about_us_text :text
#  address       :string
#  discarded_at  :datetime
#  email         :string           not null
#  facebook_url  :string
#  instagram_url :string
#  linkedin_url  :string
#  name          :string           not null
#  phone         :integer
#  welcome_text  :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_organizations_on_discarded_at  (discarded_at)
#
FactoryBot.define do
  factory :organization do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    phone { Faker::Number.number(digits: 8) }
    email { Faker::Internet.email }
    welcome_text { Faker::Lorem.paragraph(sentence_count: 2) }
    about_us_text { Faker::Lorem.paragraph(sentence_count: 2) }
    facebook_url { Faker::Internet.url(host: 'facebook.com') }
    instagram_url { Faker::Internet.url(host: 'instagram.com') }
    linkedin_url { Faker::Internet.url(host: 'linkedin.com') }
  end
end
