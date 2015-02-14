class Cranky::Factory
  def user
    User.new do |u|
      u.email = 'test@test.ru'
      u.password = '123456'
      u.password_confirmation = '123456'
    end
  end
end
