require 'active_support/configurable'

module Railstrap
  
  # Howto override a global setting: content of config/initializers/railstrap.rb
  # Railstrap.configure do |config|
  #   config.actions = :right
  # end
  
  def self.configure(&block)
    yield @config ||= Railstrap::Configuration.new
  end

  # Global settings for Railstrap
  def self.config
    @config
  end

  class Configuration
    include ActiveSupport::Configurable
    #config_accessor :actions, :table_class, :heading_class, :th_class, :tr_class, :td_class, :numeric_td_class, :string_td_class, :date_td_class, :even_odd, :paginator_pos, :i18n

  end

  # default global-settings
  configure do |config|
    #config.actions          = :left
  end
  
end
