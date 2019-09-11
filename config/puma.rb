# Start:          `ENVIRONMENT=development bundle exec pumactl -F ./config/puma.rb start`
# Restart:        `bundle exec pumactl -F ./config/puma.rb restart`
# Phased Restart: `bundle exec pumactl -F ./config/puma.rb phased-restart`
# Stop:           `bundle exec pumactl -F ./config/puma.rb stop`

# bundle exec pumactl -S ./tmp/pids/puma.state stats
# bundle exec pumactl -F ./config/puma.rb status #=> 'Puma is started'

# Load Testing: ab -n 10000 -c 100 http://mjw-vm-ruby:3000/api
# Load Testing: ab -n 10000 -c 100 http://sinboi.0nezer0.com/api
# Load Testing: ab -n 10000 -c 100 https://sinboi.0nezer0.com/api

require 'awesome_print'

app_path = Dir.pwd

directory app_path

environment ENV["ENVIRONMENT"]

activate_control_app "unix://#{app_path}/tmp/pids/pumactl.sock", { no_token: true }
pidfile    "#{app_path}/tmp/pids/puma.pid"
state_path "#{app_path}/tmp/pids/puma.state"
bind       "unix://#{app_path}/tmp/pids/puma.sock"

port ENV['PORT'] || 3000

debug
tag 'HomeDash'
#daemonize true
#log_requests false
#quiet
#stdout_redirect './tmp/logs/access.log', './tmp/logs/error.log', true

#workers `nproc`
threads 5, 5

# For Puma logs only, see startup stdout on startup. THis does not affect Rack Logs
log_formatter do |str|
  "[#{Process.pid}] [#{Socket.gethostname}] #{Time.now}: #{str}"
end

on_restart do
  puts '[PUMACTL] Restarting...'
end

before_fork do
  puts '[PUMACTL] before_fork...'
end

on_worker_boot do
  puts '[PUMACTL] on_worker_boot...'
end

on_worker_fork do
  puts '[PUMACTL] on_worker_fork...'
end

after_worker_boot do # Alias: after_worker_fork
  puts '[PUMACTL] after_worker_boot...'
end

on_worker_shutdown do
  puts '[PUMACTL] on_worker_shutdown...'
end