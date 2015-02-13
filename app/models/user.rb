class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 6 }, if: :validate_password?
  validates :password, confirmation: true, if: :validate_password?
  validates :password_confirmation, presence: true, if: :validate_password?

  validates :email, presence: true, uniqueness: true

  def as_json(options = {})
    super(except: [:crypted_password, :salt, :created_at, :updated_at])
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
