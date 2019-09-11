require 'rubygems'
require 'bundler'

# Setup load paths
Bundler.require
$LOAD_PATH << File.expand_path(__dir__)
$LOAD_PATH << File.expand_path('lib', __dir__)


require 'sinatra/base'
require 'yaml'
require 'awesome_print'
require 'sinatra/contrib'

# Require routes file
require "#{Dir.pwd}/app/extensions"
require "#{Dir.pwd}/app/helpers"
require "#{Dir.pwd}/app/routes"

# Module: MicrositePlatform
module MicrositePlatform

  # Class: MicrositePlatform::App
  class App < Sinatra::Base
    
    # Global Configuration: App always requires these
    require "#{Dir.pwd}/lib/MicrositePlatform/Log/Log.rb"
    register Sinatra::Log

    # Log: Configure
    Sinatra::Log.configure do |config|
      config.prepender = '[MicrositePlatform]'
      config.timestamp = true
    end

    # Set as Sinatra application setting
    set :log, Sinatra::Log.new()

    ROOTDIR           = Dir.pwd
    # MicrositePlatform::App.settings.global_cache_time
    set :global_cache_time, 3600

    # Load App Specific Configuration
    # Access Via: self.settings.appConfig
    set :appConfig, YAML.load_file("#{ENV['PWD']}/app.yml")

    # Only load it if it is defined in the `./app.yml` file...
    if self.settings.appConfig[:features].include? "apiMode"
      require "#{Dir.pwd}/lib/MicrositePlatform/API/API.rb"
    end

    # Load Routes
    use Rack::SSL
    use Routes::Static
    use Routes::Assets unless settings.production?
    use Routes::Main
  end
end