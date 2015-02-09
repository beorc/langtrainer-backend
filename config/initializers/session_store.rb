# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_langtrainer_backend_session'
#Rails.application.config.session_store :redis_store, "#{ENV['REDISTOGO_URL']}/sessions".gsub('//', '/'), { expires_in: 90.minutes }
Rails.application.config.session_store = :dalli_store,
  (ENV["MEMCACHIER_SERVERS"] || "").split(","),
  {:username => ENV["MEMCACHIER_USERNAME"],
   :password => ENV["MEMCACHIER_PASSWORD"],
   :failover => true,
   :socket_timeout => 1.5,
   :socket_failure_delay => 0.2,
   :namespace => 'sessions',
   :expires_in => 1.week
  }
