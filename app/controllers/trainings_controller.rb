class TrainingsController < ApplicationController
  def show
    options = {
      apiEndpoint: ENV['LANGTRAINER_API_ENDPOINT'],
      yaMetrikaId: ENV['YA_METRIKA_ID']
    }

    if logged_in?
      options[:currentUser] = current_user.to_json
    end

    styx_initialize_with(options)
  end
end
