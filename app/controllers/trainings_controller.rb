class TrainingsController < ApplicationController
  def show
    options = {
      apiEndpoint: ENV['LANGTRAINER_API_ENDPOINT'],
      yaMetrikaId: ENV['YA_METRIKA_ID']
    }

    options[:currentUser] = logged_in? ? current_user.as_json : {}
    options[:currentUser].merge! csrf_options

    styx_initialize_with(options)
  end
end
