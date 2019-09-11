# See: https://github.com/petebrowne/sprockets-helpers

# Module: MicrositePlatform
module MicrositePlatform
  # Module: MicrositePlatform::Extensions
  module Extensions
    # Module: MicrositePlatform::Extensions::Assets
    module Assets
      module_function

      # Class: UnknownAsset
      class UnknownAsset < StandardError; end

      # Module: MicrositePlatform::Extensions::Assets::Helpers
      module Helpers
        # Set up asset_path helper
        # @param name [String] the asset name
        # @return [String] the asset path
        def asset_path(name)
          asset = settings.assets[name]
          raise UnknownAsset, "Unknown asset: #{name}" unless asset
          "#{settings.asset_host}/assets/#{asset.digest_path}"
        end
      end

      # Set Asset Pipeline / Sprockets
      # @param app [Object] the app object
      def registered(app)
        # Assets
        app.set :assets, assets = Sprockets::Environment.new(app.settings.root)

        assets.append_path('app/assets/javascripts')
        assets.append_path('app/assets/stylesheets')
        assets.append_path('app/assets/images')
        assets.append_path('app/assets/videos')

        assets.append_path('app/assets/libs/javascripts')
        assets.append_path('app/assets/libs/stylesheets')
        assets.append_path('app/assets/libs/fonts')
        assets.append_path('assets')

        # Pluck js file paths out of Features folder and add to asset path
        Dir['lib/Features/**/*.js'].each do |featureAsset|
          assets.append_path(File.expand_path( File.dirname( featureAsset )))
        end

        # Configure Sprockets::Helpers (if necessary)
        Sprockets::Helpers.configure do |config|
          config.environment = assets
          config.digest      = true

          # Force to debug mode in development mode
          # Debug mode automatically sets
          # expand = true, digest = false, manifest = false
          config.debug       = true if app.development?
        end

        #assets.cache          = Sprockets::Cache::FileStore.new('./tmp')
        assets.js_compressor  = Uglifier.new(harmony: true)
        assets.css_compressor = :scss

        app.helpers Helpers
      end
    end
  end
end
