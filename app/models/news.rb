# frozen_string_literal: true

# == Schema Information
#
# Table name: news
#
#  id           :bigint           not null, primary key
#  content      :text             not null
#  discarded_at :datetime
#  image        :string           not null
#  name         :string           not null
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
class News < ApplicationRecord
  include Discard::Model

  belongs_to :category

  validates :name, :content, :image, presence: true
end
