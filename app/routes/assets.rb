# Module: MicrositePlatform
module MicrositePlatform
  # Module: MicrositePlatform::Routes
  module Routes
    # Module: MicrositePlatform::Routes::Assets
    class Assets < Base
      # Set up Assets route
      get '/assets/*' do
        env['PATH_INFO'].sub!(%r{^/assets}, '')
        # Override default sprockets cache settings
        asset                     = settings.assets.call(env)
        asset[1]['Cache-Control'] = "public, max-age=#{MicrositePlatform::App.settings.global_cache_time}"
        asset
      end
    end
  end
end