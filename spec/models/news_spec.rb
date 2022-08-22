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
require 'rails_helper'

RSpec.describe News, type: :model do
  subject { create(:news) }

  describe 'Factory' do
    it { is_expected.to be_valid }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:category) }
  end

  describe 'Database' do
    it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
    it { is_expected.to have_db_column(:content).of_type(:text).with_options(null: false) }
    it { is_expected.to have_db_column(:discarded_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    it { is_expected.to have_db_column(:news_type).of_type(:string).with_options(default: 'news') }
    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
  end

  describe 'Indexes' do
    it { is_expected.to have_db_index(:discarded_at) }
    it { is_expected.to have_db_index(:category_id) }
  end
end
