class Api::Users::ActivationsController < Api::ApplicationController
  def update
    if (user = User.find_by(id: params[:id]))
      user.send(:send_activation_needed_email!)
      render json: {}, status: :ok
    else
      render json: {}, status: :not_found
    end
  end
end
