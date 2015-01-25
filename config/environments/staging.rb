# Based on production defaults
require Rails.root.join('config/environments/production')

Rails.application.configure do
  config.middleware.use '::Rack::Auth::Basic' do |u, p|
    [u, p] == [ENV['AUTH_USER'], ENV['AUTH_PASSWORD']]
  end
end
