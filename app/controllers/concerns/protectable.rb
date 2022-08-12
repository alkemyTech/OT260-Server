# frozen_string_literal: true

module Protectable
  extend ActiveSupport::Concern

  def check_user
    redirect_to api_v1_auth_login_path, status: :forbidden unless admin?
  end
end
