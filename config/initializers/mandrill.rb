MandrillDm.configure do |config|
  config.api_key = ENV['MANDRILL_APIKEY']
  config.async = true
end
