# frozen_string_literal: true

class JsonWebToken
  def self.encode(payload)
    payload[:exp] = payload[:exp] || 15.minutes.after(Time.zone.now).to_i
    JWT.encode(payload, ENV.fetch('JWT_SECRET_KEY'))
  end

  def self.decode(token)
    decoded = JWT.decode(token, ENV.fetch('JWT_SECRET_KEY'))[0]
    HashWithIndifferentAccess.new decoded
  end
end
