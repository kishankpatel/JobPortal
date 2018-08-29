class NotificationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification_mailer.invite.subject
  #
  default from: 'kishanptl.kp@gmail.com'
  def invite(candidate,job,invitation)
  	@candidate = candidate
  	@job = job
  	@invitation = invitation
    mail(to: candidate.email, subject: "Invitation for interview from #{job.organization.name}")
  end
end
