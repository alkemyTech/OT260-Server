# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  email        :string           not null
#  first_name   :string           not null
#  last_name    :string           not null
#  password     :string           not null
#  photo        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  role_id      :bigint           not null
#
# Indexes
#
#  index_users_on_discarded_at  (discarded_at)
#  index_users_on_email         (email) UNIQUE
#  index_users_on_role_id       (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
FactoryBot.define do
  factory :user do
    first_name { 'MyString' }
    last_name { 'MyString' }
    email { 'MyString' }
    password { 'MyString' }
    photo { 'MyString' }
  end
end
