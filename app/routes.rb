# Module: MicrositePlatform
module MicrositePlatform
  # Module: MicrositePlatform::Routes
  #
  # Defines all route Classes
  # These must also be defined in +/app.rb+ as:
  #   use Routes::Main
  module Routes
    # Load Routes
    autoload :Base,   "#{Dir.pwd}/app/routes/base"
    autoload :Assets, "#{Dir.pwd}/app/routes/assets"
    autoload :Static, "#{Dir.pwd}/app/routes/static"
    autoload :Main,   "#{Dir.pwd}/app/routes/main"
  end
end