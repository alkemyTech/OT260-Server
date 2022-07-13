# frozen_string_literal: true

# == Schema Information
#
# Table name: members
#
#  id           :bigint           not null, primary key
#  description  :string
#  discarded_at :datetime
#  facebookUrl  :string
#  instagramUrl :string
#  linkedinUrl  :string
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_members_on_discarded_at  (discarded_at)
#
require 'rails_helper'

RSpec.describe Member, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
