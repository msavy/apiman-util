require 'trollop'
require 'trollop/subcommands'

module Apiman::Diagnostics
  class OptionParser
    Trollop::Subcommands::register_global do
      banner <<-END
    Usage
      #{$0} COMMAND [command options]

    COMMANDS
      policy

    Additional help
      #{$0} COMMAND -h

    Options
      END
      opt :username, 'Username', type: :string, short: 'u', required: true
      opt :password, 'Password', type: :string, short: 'p', required: true
    end

    def self.parse
      Trollop::Subcommands::parse!
    end
  end
end
