# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  default from: 'alkemy.mailer@gmail.com'

  def send_welcome_email(user)
    @user = user
    mail(to: @user.email)
  end
end
