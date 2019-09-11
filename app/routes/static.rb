# Module: MicrositePlatform
module MicrositePlatform
  # Module: MicrositePlatform::Routes
  module Routes
    # Class: MicrositePlatform::Routes::Static
    #
    # This Route Class handle serving static files, both from the Public directory (+/+), +/docs+, etc.
    class Static < Sinatra::Application
      # Configure Static Routes
      configure do
        set :views, 'app/views'
        set :root, App.root
        disable :method_override
        disable :protection
        enable :static
      end

      # Set up static routes
      def static!
        if request.path_info.include? '/.doc/'
          @auth ||= Rack::Auth::Basic::Request.new(request.env)
          if @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == %w[admin admin]
          else
            headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
            halt 401, "Not authorized\n"
          end
        end

        return if (public_dir = settings.public_folder).nil?
        public_dir = File.expand_path(public_dir)

        path = File.expand_path(public_dir + unescape(request.path_info))
        return unless path.start_with?(public_dir) && File.file?(path)

        env['sinatra.static_file'] = path

        unless settings.development? || settings.test?
          expires 60, :public, max_age: 300
          headers 'Date' => Time.now.httpdate
        end

        send_file path, disposition: nil
      end
    end
  end
end
