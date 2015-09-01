web: bundle exec passenger start -p $PORT --friendly-error-pages
worker: bundle exec rails jobs:work
worker: bundle exec sidekiq -c 3 -v