# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id            :bigint           not null, primary key
#  about_us_text :text
#  address       :string
#  discarded_at  :datetime
#  email         :string           not null
#  name          :string           not null
#  phone         :integer
#  welcome_text  :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_organizations_on_discarded_at  (discarded_at)
#
class Organization < ApplicationRecord
  include Discard::Model

  has_one_attached :image

  validates :name, :email, :welcome_text, presence: true
  validates :phone, numericality: { only_integer: true }, allow_blank: true
  validates :email, format: { with: /[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}/ }
end
