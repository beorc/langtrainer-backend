class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def csrf_options
    {
      csrf_param: request_forgery_protection_token,
      csrf_token: form_authenticity_token
    }
  end
end
