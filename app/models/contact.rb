# frozen_string_literal: true

# == Schema Information
#
# Table name: contacts
#
#  id         :bigint           not null, primary key
#  deletedAt  :date
#  email      :string
#  name       :string
#  phone      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Contact < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
end
