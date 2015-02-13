class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, on: :create
  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

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
end
