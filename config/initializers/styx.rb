Rails.application.config.to_prepare do
  ActionController::Base.send :include, Styx::Initializer
end
