class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :gon_environment

  private

  def gon_environment
    options = {
      apiEndpoint: ENV['LANGTRAINER_API_ENDPOINT'],
      authApiEndpoint: ENV['AUTH_API_ENDPOINT'],
      yaMetrikaId: ENV['YA_METRIKA_ID']
    }

    options[:currentUser] = logged_in? ? current_user.as_json : {}
    options[:currentUser][:native_language_slug] ||= I18n.locale
    options[:locales] = {}

    I18n.available_locales.each do |locale|
      options[:locales][locale] = localization(locale)
    end

    gon.common = options
  end

  def set_locale
    I18n.locale = params[:locale] || current_user.try(:native_language_slug) || cookies[:native_language_slug] || extract_locale_from_accept_language_header || I18n.default_locale
  end

  def extract_locale_from_accept_language_header
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].try(:scan, /^[a-z]{2}/).try(:first).try(:to_sym)
    I18n.available_locales.find { |l| l == locale }
  end

  def localization(locale)
    saved_locale = I18n.locale
    I18n.locale = locale
    result = I18n.t('langtrainer')
    I18n.locale = saved_locale
    result
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end
end
