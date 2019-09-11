require "#{Dir.pwd}/lib/MicrositePlatform/Log/Log.rb"

namespace :log do
  scope = Rake.application.current_scope

  desc "configuration"
  task :configuration do
    puts "Testing rake task: ".green << "rake #{Rake.application.top_level_tasks[0]}\n\n"

    # Sinatra::Log: DEFAULT configuration
    Sinatra::Log.reset

    puts "With " << "*DEFAULT*".green << " Configuration:"
    Sinatra::Log.configuration.instance_variables.each do |instanceVariable|
      ivKey   = instanceVariable
      ivValue = Sinatra::Log.configuration.instance_variable_get(instanceVariable)
      puts "  #{ivKey} = #{ivValue}"
    end
    puts "\n"

    log = Sinatra::Log.new()
    puts "Sample stdout:"
    puts "--------------------"
    log.info("This is an *info* log entry.")
    log.warning("This is an *warning* log entry.")
    log.error("This is an *error* log entry.")
    puts "--------------------\n\n"

    # Sinatra::Log: CUSTOM configuration
    Sinatra::Log.configure do |config|
      config.prepender = '[SINBOI]'
      config.timestamp = true
    end

    puts "With " << "*CUSTOM*".green << " Configuration:"
    Sinatra::Log.configuration.instance_variables.each do |instanceVariable|
      ivKey   = instanceVariable
      ivValue = Sinatra::Log.configuration.instance_variable_get(instanceVariable)
      puts "  #{ivKey} = #{ivValue}"
    end
    puts "\n"

    log = Sinatra::Log.new()
    puts "Sample stdout:"
    puts "--------------------"
    log.info("This is an *info* log entry.")
    log.warning("This is an *warning* log entry.")
    log.error("This is an *error* log entry.")
    puts "--------------------\n\n"

  end
  task configuration: :before

end