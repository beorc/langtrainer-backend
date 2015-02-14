class Api::Users::SessionsController < Api::ApplicationController
  after_action :set_csrf_headers

  module Error
    class NotActivated < StandardError; end
  end

  def create
    @session = User::Session.new(self)
    @session.email = params[:email]
    @session.password = params[:password]

    if @session.user.try(:valid?) && @session.user.inactive?
      raise Error::NotActivated
    end

    if @session.save
      render json: { user: @session.user }, status: :created
    else
      render json: { errors: @session.errors }, status: :unprocessable_entity
    end

  rescue Error::NotActivated => exception
    @session.user.send(:send_activation_needed_email!)
    render json: { id: @session.user.id }, status: :unauthorized
  end

  def destroy
    logout
    render json: { user: {} }
  end
end
