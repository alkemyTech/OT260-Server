# frozen_string_literal: true

module Sendeable
  extend ActiveSupport::Concern

  def self.send_email(email, subject)
    UserNotifierMailer.send_email({ to: email, subject: subject }).deliver
  end
end
