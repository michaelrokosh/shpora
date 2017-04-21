web: bundle exec thin start -p $PORT
worker: bundle exec sidekiq -q devise -q default -e production -c 5
