# frozen_string_literal: true

# == Schema Information
#
# Table name: slides
#
#  id              :bigint           not null, primary key
#  order           :integer
#  text            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_slides_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
require 'rails_helper'

RSpec.describe Slide, type: :model do
  subject { create(:slide) }

  describe 'Factory' do
    it { is_expected.to be_valid }
  end

  describe 'Associations' do
     it { is_expected.to belong_to(:organization) }
  end

  describe 'Database' do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:order).of_type(:integer) }
    it { is_expected.to have_db_column(:text).of_type(:string) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end
end
