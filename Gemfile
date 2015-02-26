ruby '2.2.0'
source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'bootstrap-sass', '~> 3.3.3'
gem 'font-awesome-rails'
gem 'compass-rails'
gem 'slim-rails'
gem 'active_link_to'
gem 'sorcery'
gem 'rails-i18n'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
#gem 'sdoc', '~> 0.4.0', group: :doc

gem 'rollbar', '~> 1.3.1'
gem 'meta-tags', require: 'meta_tags'
gem 'gon'
gem 'langtrainer_frontend_backbone', github: 'langtrainer/langtrainer_frontend_backbone', branch: 'master'
gem 'mandrill-api'
gem 'mandrill_dm', github: 'beorc/mandrill_dm', branch: 'master'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'puma'
  gem 'rails_12factor'
  gem 'dalli'
  gem "memcachier"
  gem 'rack-cache'
  gem 'kgio'
  gem 'connection_pool'
  gem "fog", "~>1.20", require: "fog/aws/storage"
  gem "asset_sync"
end

group :development, :test do
  gem 'figaro'
end

group :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
end

group :test do
  gem 'launchy', '>= 2.1.2'
  gem 'capybara', '>= 2.0.2'
  gem 'sqlite3'

  gem 'rspec-rails'
  gem 'cranky'
  gem 'database_cleaner'
  gem 'poltergeist'
  gem 'approvals', '~> 0.0.16'
  gem 'shoulda-matchers', require: false
end
