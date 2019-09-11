# Handler for /docs/
require 'sinatra/base'

# Module: MicrositePlatform
module MicrositePlatform

  # Class: MicrositePlatform::Docs
  class Docs < Sinatra::Base

    # @method helpers
    # Docs helpers
    helpers do

      # @!method protected!
      # Add basic auth for +/docs+ route
      def protected!
        return if authorized?
        headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
        halt 401, "Not authorized\n"
      end

      # 
      # Check if user is authorized
      #    
      def authorized?
        @auth ||= Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? && @auth.basic? && @auth.credentials && (@auth.credentials == ['admin', 'rh123456!'])
      end
    end

    set :public_folder, "#{App::ROOTDIR}/app/mounts/docs"
    set :static, true
    set :method_override, true

    # @method before
    # Run before all requests to the +/docs+ route
    before do
      # Add trailing slash
      redirect 'docs/' if env['REQUEST_PATH'][-1] != '/'
    end

    # @method get_docs_route
    # @note Handles GET Route +/docs+
    get '/' do
      protected!

      File.read(File.join("#{App::ROOTDIR}/app/mounts/docs", 'index.html'))
    end
  end
end
