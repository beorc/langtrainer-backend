class User::Session
  include ActiveModel::Validations

  attr_reader :context
  attr_accessor :email
  attr_accessor :password

  validates_presence_of :email
  validates_presence_of :password
  validate :user_present
  validate :password_correct

  def initialize(context)
    @context = context
  end

  def save
    if valid?
      return !!context.login(email, password)
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

  def password_correct
    if user && !user.valid_password?(password)
      errors.add :password, I18n.t('errors.messages.invalid')
    end
  end
end

