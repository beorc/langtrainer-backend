class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 6 }, if: :validate_password?
  validates :password, confirmation: true, if: :validate_password?
  validates :password_confirmation, presence: true, if: :validate_password?

  validates :email, presence: true, uniqueness: true

  def as_json(options = {})
    super(only: [
      :id,
      :email,
      :activation_state,
      :token,
      :current_course_slug,
      :language_slug,
      :native_language_slug,
      :question_help_enabled
    ])
  end

  def active?
    activation_state == 'active'
  end

  def inactive?
    !active?
  end

  private

  def validate_password?
    new_record? || password.present?
  end
end
