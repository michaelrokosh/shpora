Devise.setup do |config|
  config.secret_key = 'da30a354e94e846a932a5c35d83f83f31de8e8b5e3372f7887ba35cda0d5f31250b56a53687290d75045a285bd93a8f19a591a29aa73545e2a6227250a8afd66'
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.authentication_keys = [ :username ]
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.password_length = 1..128
  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  require "omniauth-vkontakte"
  config.omniauth :vkontakte, ENV['VK_KEY'], ENV['VK_SECRET']

  config.omniauth :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  config.omniauth :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
end
