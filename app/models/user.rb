class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, presence: true, uniqueness: true

  def to_builder
    Jbuilder.new do |user|
      user.(self, :id, :email)
    end
  end
end
