source 'https://rubygems.org'
ruby '2.3.2'

gem 'rails', '4.2.2'

gem 'pg'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'thin'
gem 'dotenv-rails', groups: [:development, :test]

# services
gem 'airbrake'
gem 'redis-rails'
gem 'sidekiq'
gem 'sendgrid'

# file uploads
gem 'aws-sdk', '~> 2'
gem 'carrierwave'
gem 'fog-aws'
gem 'yomu'

gem 'haml'

gem 'htmltoword'

group :doc do
  gem 'sdoc', require: false
end

#auth
gem 'devise'
gem 'devise-async'
gem 'koala'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-vkontakte'
gem 'omniauth-oauth2'
gem 'omniauth-google-oauth2'

gem 'turbolinks', '~> 5.0.0'
gem 'font-awesome-sass'
gem 'google-webfonts'
gem 'haml-rails'
gem 'ckeditor_rails'
gem 'will_paginate'
gem 'acts-as-taggable-on'
gem 'newrelic_rpm'
gem 'sitemap_generator'
gem 'twitter-typeahead-rails'

# Until the new API calls are generally available, you must manually specify my fork
# of the Heroku API gem:
gem 'platform-api', git: 'https://github.com/jalada/platform-api', branch: 'master'

group :production do
  gem 'rails_12factor'
  gem 'letsencrypt-rails-heroku'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
end
