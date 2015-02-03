class Api::Users::SessionsController < ApplicationController
  def create
    user = login(params[:email], params[:password])
    if user
      render json: user, status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    render nothing: true
  end
end
