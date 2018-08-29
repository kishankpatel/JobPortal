class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.invite.subject
  #
  def invite
    @greeting = "Hi"

    mail to: "ghabhradip@gmail.com"
  end
end
