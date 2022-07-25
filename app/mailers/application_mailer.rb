# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@somosmas.org'
  layout 'mailer'
end
