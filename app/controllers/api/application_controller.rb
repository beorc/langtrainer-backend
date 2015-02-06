class Api::ApplicationController < ApplicationController
  ALLOWED_SITES = [ENV['AUTH_API_ENDPOINT']]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, except: :handle_options_request
  after_action :set_access_control_headers

  def handle_options_request
    head(:no_content) if request.request_method == 'OPTIONS'
  end

  private

  # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS?redirectlocale=en-US&redirectslug=HTTP_access_control
  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, X-CSRF-Token'
    headers['Access-Control-Max-Age'] = '1728000'
    headers['X-Frame-Options'] = 'GOFORIT'
  end
end
