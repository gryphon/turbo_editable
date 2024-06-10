require "turbo_editable/version"
require "turbo_editable/engine"
require "turbo_editable/configuration"

module TurboEditable
  def self.configuration
    @configuration ||= Configuration.new
  end
  
  def self.configure(&block)
    yield(configuration)
  end
end
