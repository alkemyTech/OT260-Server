# frozen_string_literal: true

module Authorizable
  extend ActiveSupport::Concern
  def authorization
    render json: { error: 'You are not an administrator' }, status: :forbidden unless admin?
  end

  def admin?
    @current_user.role.name == 'administrator'
  end

  def owner?
    params[:id].to_i == @current_user.id
  end

  def ownership?
    render json: { errors: 'Unauthorized access' }, status: :forbidden unless admin? || owner?
  end
end
