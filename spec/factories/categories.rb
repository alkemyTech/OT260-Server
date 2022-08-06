# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id           :bigint           not null, primary key
#  description  :string
#  discarded_at :datetime
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_categories_on_discarded_at  (discarded_at)
#
FactoryBot.define do
  factory :category do
    name { "Category #{rand(1..20)}" }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end
