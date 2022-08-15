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
class CategorySerializer
  include JSONAPI::Serializer

  attributes :name, :description
  attributes :image do |category|
    category.image.service_url if category.image.attached?
  end
  has_many :news
end
