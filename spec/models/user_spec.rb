# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  discarded_at    :datetime
#  email           :string           not null
#  first_name      :string           not null
#  last_name       :string           not null
#  password_digest :string           not null
#  photo           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role_id         :bigint           not null
#
# Indexes
#
#  index_users_on_discarded_at  (discarded_at)
#  index_users_on_email         (email) UNIQUE
#  index_users_on_role_id       (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
