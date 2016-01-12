require "apiman/diagnostics/version"
require "apiman/diagnostics/optionparser"
require "rest-client"

module Apiman
  module Diagnostics
    PLUGINS = {}

    def self.register_plugin(subcommand, clazz)
      PLUGINS[subcommand] = clazz
    end

    PLUGINS_LOCATION = File.join(__dir__, 'diagnostics/commands/*.rb')
    Dir[PLUGINS_LOCATION].each { |plugin| require(plugin) }
    OPTS = OptionParser.parse

    def self.start
      PLUGINS[OPTS.subcommand].new(OPTS)
    end

    start
  end
end
