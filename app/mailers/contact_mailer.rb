# frozen_string_literal: true

class ContactMailer < ApplicationMailer
  def send_contact_email(user, subject)
    @user = user
    @subject = subject
    mail(to: @user.email, subject: @subject)
  end
end
