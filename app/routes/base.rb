# Module: MicrositePlatform
module MicrositePlatform
  # Module: MicrositePlatform::Routes

  module Routes
    
    # Class: MicrositePlatform::Routes::Base
    #
    # This is the Base Class for all routes. This Class is responsible for route configuration for all inherited route Classes. No actual routes are configured here.
    # 
    # All route Classes inherit Base:
    # @see #MicrositePlatform::Routes::Main
    class Base < Sinatra::Application
      # @method before
      # Run before all requests
      before do
        #MicrositePlatform::App.settings.log.info("#{self.class} says hello!")
      end

      # @method configure
      # Application configuration should go here as this base route is evaluated with every request
      configure do
        disable :method_override
        enable :use_code

        set :erb, escape_html: true
        set :protection, except: [:json_csrf]

        # Base views for App
        set :views, ['app/views/pages', 'app/views/layouts']

        set :public_folder, 'app/public'
        set :root, App.root

        puts "Sinatra configuration Complete!".green
      end

      helpers do
        def find_template(views, name, engine, &block)
          #ap views
          views.each { |v| super(v, name, engine, &block) }
        end
      end

      register Extensions::Assets
      helpers Helpers
      helpers Sinatra::ContentFor
    end
  end
end