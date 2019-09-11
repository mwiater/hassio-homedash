#!/usr/bin/env rake
require 'rubygems'
require 'bundler'

# Setup load paths
Bundler.require

# Setup Rake tasks
Rake::TaskManager.record_task_metadata = true
Dir.glob('./lib/tasks/*.rake').each { |r| load r }

# Require all ruby files in './lib'
Dir.glob('./lib/Sinboiv2/*.rb').each { |r| require r }

require 'awesome_print'

# Run before any rake tasks
desc 'Clear screen'
task :before do
  system 'clear'
end

desc 'List all rake tasks'
task :default do
  puts 'Rake Tasks:'.green
  system 'rake -T'
end
task default: :before