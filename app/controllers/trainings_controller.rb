class TrainingsController < ApplicationController
  def show
    styx_initialize_with(
      apiEndpoint: ENV['LANGTRAINER_API_ENDPOINT'],
      yaMetrikaId: ENV['YA_METRIKA_ID'],
      currentUser: current_user.to_builder.target!
    )
  end
end
