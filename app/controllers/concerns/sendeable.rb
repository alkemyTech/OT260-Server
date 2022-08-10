# frozen_string_literal: true

module Sendeable
  extend ActiveSupport::Concern

  def self.contact_notification_email(user, subject)
    ContactMailer.send_contact_email(user, subject).deliver_later
  end

  def self.welcome_notification_email(user, subject)
    WelcomeMailer.send_welcome_email(user, subject).deliver_later
  end
end
