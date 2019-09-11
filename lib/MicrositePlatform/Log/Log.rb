# REF: https://www.skcript.com/svr/the-easiest-configuration-block-for-your-ruby-gems/
require 'awesome_print'
require 'sinatra/base'


# Module: Sinatra
module Sinatra

  # Module: Log
  # @example
  #   require "#{Dir.pwd}/lib/MicrositePlatform/Log/Log.rb"
  #
  #   Sinatra::Log.configure do |config|
  #     config.prepender = '[MicrositePlatform]'
  #     config.timestamp = true
  #   end
  #
  #   set :log, Sinatra::Log.new()
  module Log

    class << self
      attr_accessor :configuration

      # 
      # Set configuration settings for: Sinatra::Log
      # @yieldparam [Object] configuration
      def configure
        self.configuration ||= LogConfiguration.new

        yield(configuration)
      end


      # 
      # Reset configuration settings for: Sinatra::Log
      #    
      def reset
        self.configuration = LogConfiguration.new
      end
    end


    # 
    # Fake constructor, module acts like Class
    # 
    # @return [Object] self
    def self.new()
      Log.configuration ||= LogConfiguration.new

      self
    end


    # 
    # Create log entry from parts
    # @param text [String] Log text
    # 
    # @return [String] assembled log entry
    def self.assembleLogMessage(text)
      timestamp = Log.configuration.timestamp ? Time.now.to_s.pale + " " : ""
      prepender = !Log.configuration.prepender.empty? ? Log.configuration.prepender.white + " " : ""

      timestamp << prepender
    end


    # 
    # Create Info level log enty
    # @example
    #   log.info("This is an *info* log entry.")
    # @param text [String] Log text
    # 
    # @return [String] Info log entry
    def self.info(text)
      puts "#{assembleLogMessage(text)}" << "[INFO]    #{text}".green
    end


    # 
    # Create Warning level log enty
    # @example
    #   log.warning("This is an *warning* log entry.")
    # @param text [String] Log text
    # 
    # @return [String] Warning log entry
    def self.warning(text)
      puts "#{assembleLogMessage(text)}" << "[WARNING] #{text}".cyan
    end


    # 
    # Create Error level log enty
    # @example
    #   log.error("This is an *error* log entry.")
    # @param text [String] Log text
    # 
    # @return [String] Error log entry
    def self.error(text)
      puts "#{assembleLogMessage(text)}" << "[ERROR]   #{text}".red
    end
  end


  # Class: LogConfiguration
  class LogConfiguration
    attr_accessor :prepender
    attr_accessor :timestamp


    # 
    # Configuration for Sinatra::Log
    # Sets Class instance variables
    def initialize
      @prepender = ""
      @timestamp = false
    end
  end

  register Log
end