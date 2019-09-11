require './app'
require './app/mounts/docs'

# Base Routes
urlMap             = {}
urlMap["/"]        = MicrositePlatform::App.new

if ENV['RACK_ENV'] != "production"
  urlMap["/docs"]    = MicrositePlatform::Docs.new
end

run Rack::URLMap.new urlMap