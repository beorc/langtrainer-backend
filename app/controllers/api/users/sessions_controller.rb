class Api::Users::SessionsController < ApplicationController
  def create
    @session = User::Session.new(self)
    @session.email = params[:email]
    @session.password = params[:password]
    @session.save

    if @session.valid?
      render json: { user: @session.user.as_json.merge(csrf_options) }, status: :created
    else
      render json: { errors: @session.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    render json: { user: csrf_options }
  end
end
