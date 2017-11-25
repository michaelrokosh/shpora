Shpora::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false

  # Uncomment these lines to force SSL. Then run heroku run rake letsencrypt:renew --app shpora
  # config.middleware.insert_before ActionDispatch::SSL, Letsencrypt::Middleware
  # config.force_ssl = true

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.0'
  config.log_level = :info
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify
  config.action_mailer.default_url_options = { host: 'shpora.me' }
  config.log_formatter = ::Logger::Formatter.new

  config.action_mailer.default_options = { from: 'no-reply@shpora.me' }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: '587',
    enable_starttls_auto: true,
    user_name: ENV['GMAIL_USERNAME_SHPORA'],
    password: ENV['GMAIL_PASSWORD_SHPORA'],
    authentication: :plain,
    domain: 'shpora.me'
  }
end
