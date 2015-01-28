class TrainingsController < ApplicationController
  def show
    styx_initialize_with(
      apiEndpoint: ENV['LANGTRAINER_API_ENDPOINT']
    )
  end
end
