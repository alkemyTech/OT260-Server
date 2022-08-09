# frozen_string_literal: true

# == Schema Information
#
# Table name: contacts
#
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  email        :string           not null
#  message      :text
#  name         :string           not null
#  phone        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_contacts_on_discarded_at  (discarded_at)
#  index_contacts_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ContactSerializer
  include JSONAPI::Serializer
  attributes :email, :name, :phone

  belongs_to :user
end
