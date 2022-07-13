# frozen_string_literal: true

class Member < ApplicationRecord
  include Discard::Model

  has_one_attached :image
  validates :name, presence: true
end
