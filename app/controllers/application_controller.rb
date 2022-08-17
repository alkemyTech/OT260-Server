# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authorizable
  include Authenticable
  include Uploadable
  include Sendeable
  include Protectable
  include ActiveStorage::SetCurrent
end
