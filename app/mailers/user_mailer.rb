class UserMailer < ActionMailer::Base
  def activation_needed_email(user)
    @user = user
    @url  = "#{Rails.configuration.x.root_url}/users/#{user.activation_token}/activate"
    mail(
      to: user.email,
      subject: I18n.t('user_mailer.activation_needed_email.subject')
    )
  end

  def reset_password_email(user)
    @user = user
    @url  = edit_user_password_reset_url(user.reset_password_token)
    mail(
      to: user.email,
      subject: I18n.t('user_mailer.reset_password_email.subject')
    )
  end
end
