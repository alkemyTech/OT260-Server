# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :category do
    name { "MyString" }
    description { "MyString" }
  end
end
