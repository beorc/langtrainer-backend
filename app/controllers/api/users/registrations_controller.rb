class Api::Users::RegistrationsController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      render json: @user.to_builder.target!, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end
end
