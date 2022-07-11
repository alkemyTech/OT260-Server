# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  address    :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :person do
    name { "MyString" }
    address { "MyString" }
  end
end
