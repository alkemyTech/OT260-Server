# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'ong.alkemy.mailer@gmail.com'
  layout 'mailer'
end
