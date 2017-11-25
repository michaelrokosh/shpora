web: bundle exec thin start -p $PORT
worker: bundle exec sidekiq -q devise -q default -q mailer -e production -c 5
