# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
<<<<<<< HEAD
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  email        :string           not null
#  first_name   :string           not null
#  last_name    :string           not null
#  password     :string           not null
#  photo        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  role_id      :bigint           not null
=======
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
>>>>>>> a2f41c10f3c85cb832fb9d1f5e41659b0a0fec9c
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
class User < ApplicationRecord
  include Discard::Model
  has_secure_password

  belongs_to :role

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true
end
