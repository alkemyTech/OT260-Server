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
    content { Faker::Lorem.paragraphs }
    name { Faker::Name.name }
    news_type { 'news' }

    association :category

    after(:build) do |user|
      user.image.attach(
        io: File.open(Rails.root.join('spec/factories_files/test.png')),
        filename: 'user_icon.jpeg',
        content_type: 'image/jpeg'
      )
    end
  end
end
