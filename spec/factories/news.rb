# frozen_string_literal: true

# == Schema Information
#
# Table name: news
#
#  id           :bigint           not null, primary key
#  content      :text             not null
#  discarded_at :datetime
#  name         :string           not null
#  news_type    :string           default("news")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :bigint           not null
#
# Indexes
#
#  index_news_on_category_id   (category_id)
#  index_news_on_discarded_at  (discarded_at)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
FactoryBot.define do
  factory :news do
    content { 'MyString' }
    image { 'MyString' }
    name { 'MyString' }
    news_type { 'news' }
    category { create(:category) }

    trait :good do
      name { Faker::Lorem.sentence }
      content { Faker::Lorem.paragraph }
      image { Faker::Lorem.sentence }
    end

    trait :bad do
      name { nil }
      content { nil }
      image { nil }
    end

    factory :good_news, traits: [:good]
    factory :bad_news, traits: [:bad]
  end
end
