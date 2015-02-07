class Api::ApplicationController < ApplicationController
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
    headers['Access-Control-Allow-Origin'] = 'http://training.langtrainer.com'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, X-Requested-With, X-Prototype-Version, X-CSRF-Token'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
    headers['Access-Control-Max-Age'] = '1728000'
    headers['X-Frame-Options'] = 'GOFORIT'
  end

  def set_csrf_headers
    # Add the newly created csrf token to the page headers
    response.headers['X-CSRF-Token'] = "#{form_authenticity_token}"
    response.headers['X-CSRF-Param'] = "#{request_forgery_protection_token}"
  end
end
