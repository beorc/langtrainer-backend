class Api::Users::SessionsController < Api::ApplicationController
  after_action :set_csrf_headers

  def create
    @session = User::Session.new(self)
    @session.email = params[:email]
    @session.password = params[:password]
    @session.save

    if @session.valid?
      render json: { user: @session.user }, status: :created
    else
      render json: { errors: @session.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    render json: { user: {} }
  end
end
