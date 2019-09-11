cd /app
bundle install
ENVIRONMENT=production bundle exec pumactl -F ./config/puma.rb start
