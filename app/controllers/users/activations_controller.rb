class Users::ActivationsController < ApplicationController
  def activate
    if (user = User.load_from_activation_token(params[:token]))
      user.activate!
      auto_login(user)
      redirect_to root_path, notice: I18n.t('flashes.activated_successfully')
    else
      not_authenticated
    end
  end
end
