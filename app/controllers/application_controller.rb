class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :styx_environment

  def self.cache_page(content, path, extension = nil, gzip = Zlib::BEST_COMPRESSION)
    super content, path.to_s + '_' + I18n.locale.to_s, extension, gzip
  end

  def self.expire_page(path)
    I18n.available_locales.each do |locale|
      super path.to_s + '_' + locale.to_s
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || current_user.try(:native_language_slug) || cookies[:native_language_slug] || extract_locale_from_accept_language_header || I18n.default_locale
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].try(:scan, /^[a-z]{2}/).try(:first)
  end

  def styx_environment
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

    styx_initialize_with(options)
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
