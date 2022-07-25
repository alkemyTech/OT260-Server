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
FactoryBot.define do
  factory :activity do
    name { 'MyString' }
    content { 'MyText' }
    discarded_at { '2022-07-21 13:28:47' }
  end
end
