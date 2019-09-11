cd /app
bundle install
ENVIRONMENT=development bundle exec pumactl -F ./config/puma.rb start
