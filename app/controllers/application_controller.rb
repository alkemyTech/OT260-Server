# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authorizable
  include Authenticable
  include Uploadable
  include Sendeable
end
