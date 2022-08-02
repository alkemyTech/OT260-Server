# frozen_string_literal: true

class UserNotifierMailer < ApplicationMailer
  def send_email(params)
    @email = params[:to]
    @subject = params[:subject]
    mail(to: @email, subject: @subject)
  end
end
