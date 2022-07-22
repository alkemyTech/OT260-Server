# frozen_string_literal: true

# == Schema Information
#
# Table name: contacts
#
#  id         :bigint           not null, primary key
#  deletedAt  :string
#  email      :string
#  message    :string
#  name       :string
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :contact do
    name { 'MyString' }
    phone { 1 }
    email { 'MyString' }
    message { 'MyString' }
    deletedAt { 'MyString' }
  end
end
