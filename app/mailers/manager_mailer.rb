class ManagerMailer < ActionMailer::Base
  def feedback(email, feedback)
    @feedback = feedback

    mail(to: email, subject: 'New feedback message')
  end
end
