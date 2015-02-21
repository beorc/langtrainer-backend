class Users::PasswordResetsController < ApplicationController
  def edit
    token = params[:id]
    user = User.load_from_reset_password_token(token)

    if user.blank?
      not_authenticated
    else
      gon.token = token
    end
  end
end
