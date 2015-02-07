class Api::Users::RegistrationsController < Api::ApplicationController
  after_action :set_csrf_headers

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      render json: { user: @user }, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end
end
