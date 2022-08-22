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
require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { create(:category) }

  describe 'Factory' do
    it { is_expected.to be_valid }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:news) }
  end

  describe 'Database' do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:description).of_type(:string) }
    it { is_expected.to have_db_column(:discarded_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'Indexes' do
    it { is_expected.to have_db_index(:discarded_at) }
  end
end
