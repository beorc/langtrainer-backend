class User::PasswordReset
  include ActiveModel::Validations

  attr_accessor :email

  validates_presence_of :email
  validate :user_present

  def save!
    if valid?
      # This line sends an email to the user with instructions on how to reset their password (a url with a random token)
      user.deliver_reset_password_instructions!
      return true
    else
      return false
    end
  end

  def user
    @user ||= User.find_by(email: email)
  end

  private

  def user_present
    unless user
      errors.add :email, I18n.t('errors.messages.invalid')
    end
  end
end

