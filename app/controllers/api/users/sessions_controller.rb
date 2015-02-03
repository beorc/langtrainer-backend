class Api::Users::SessionsController < ApplicationController
  def create
    @session = User::Session.new(self)
    @session.email = params[:email]
    @session.password = params[:password]
    @session.save

    if @session.valid?
      render json: @session.user, status: :created
    else
      render json: { errors: @session.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    render nothing: true
  end
end
