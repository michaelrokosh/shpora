web: bundle exec thin start -p $PORT
worker: bundle exec sidekiq -q default -q mailers -e production -c 5
