# Module: MicrositePlatform
module MicrositePlatform

  # Module: MicrositePlatform::Routes
  module Routes

    # Class: MicrositePlatform::Routes::Main
    class Main < Base
      before do
      end

      # @method get_home_route
      # @note Handles GET Route +/+
      get '/' do
        erb :home, :layout => :main
      end
    end
  end
end