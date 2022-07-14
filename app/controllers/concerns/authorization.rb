# frozen_string_literal: true

module Authorization
  def authorization
    render json: { error: 'You are not an administrator' }, status: :forbidden unless admin?
  end

  def admin?
    @current_user.role.name == 'administrator'
  end
end
