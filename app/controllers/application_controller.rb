# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authorizable
  include Authenticable
end
