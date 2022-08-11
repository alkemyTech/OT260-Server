# frozen_string_literal: true

# == Schema Information
#
# Table name: contacts
#
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  email        :string           not null
#  message      :text
#  name         :string           not null
#  phone        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_contacts_on_discarded_at  (discarded_at)
#  index_contacts_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :contact do
    name { Faker::Name.first_name }
    phone { Faker::PhoneNumber.phone_number_with_country_code }
    email { Faker::Internet.email }
    message { Faker::Lorem.sentence }

    association :user
  end
end
