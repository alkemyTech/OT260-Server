# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  news_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_news_id  (news_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (news_id => news.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  include Discard::Model

  belongs_to :user, optional: true
  belongs_to :news, optional: true

  validates :news_id, presence: true
  validates :user_id, presence: true
  validates :body, presence: true
end
