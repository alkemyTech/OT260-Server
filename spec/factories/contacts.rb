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
#
# Indexes
#
#  index_contacts_on_discarded_at  (discarded_at)
#
FactoryBot.define do
  factory :contact do
    name { 'MyString' }
    phone { 'MyString' }
    email { 'MyString' }
    message { 'MyText' }
    discarded_at { '' }
  end
end
