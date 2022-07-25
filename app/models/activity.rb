# frozen_string_literal: true

# == Schema Information
#
# Table name: activities
#
#  id           :bigint           not null, primary key
#  content      :text             not null
#  discarded_at :datetime
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_activities_on_discarded_at  (discarded_at)
#
class Activity < ApplicationRecord
  include Discard::Model

  has_one_attached :image
  validates :name, presence: true, length: { minimum: 2 }
  validates :content, presence: true, length: { minimum: 20 }
end
