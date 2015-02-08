class TrainingsController < ApplicationController
  def show
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

  private

  def localization(locale)
    saved_locale = I18n.locale
    I18n.locale = locale
    result = I18n.t('langtrainer')
    I18n.locale = saved_locale
    result
  end
end
