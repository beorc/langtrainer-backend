class Api::Users::RegistrationsController < Api::ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      render json: { user: @user.as_json.merge(csrf_options) }, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end
end
