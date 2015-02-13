class Api::Users::PasswordResetsController < Api::ApplicationController
  # request password reset.
  # you get here when the user entered his email in the reset password form and submitted it.
  def create
    @password_reset = User::PasswordReset.new
    @password_reset.email = params[:email]

    # Tell the user instructions have been sent whether or not email was found.
    # This is to not leak information to attackers about which emails exist in the system.
    if @password_reset.save!
      render json: { user: @password_reset.user }, status: :created
    else
      render json: { errors: @password_reset.errors }, status: :unprocessable_entity
    end
  end

  # This action fires when the user has sent the reset password form.
  def reset
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      render json: {}, status: :unauthorized
      return
    end

    # the next line makes the password confirmation validation work
    @user.password_confirmation = params[:user][:password_confirmation]
    # the next line clears the temporary token and updates the password
    if @user.change_password!(params[:user][:password])
      render json: { user: @user }, status: :success
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end
end
