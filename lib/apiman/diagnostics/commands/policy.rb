require 'rest-client'
require 'uri'
require 'json'

module Apiman::Diagnostics
  class Policy
      Apiman::Diagnostics.register_plugin("policy", self);

      Trollop::Subcommands::register_subcommand('policy') do
        banner <<-END
      Usage
        #{File.basename($0)} policy [options]
      Options
        END
        opt :info, 'Print full policy data with given URL', type: :string
        opt :config, 'Print just policy user config with given URL', type: :string
      end

      def initialize(opts)
        @username = opts.global_options[:username]
        @password = opts.global_options[:password]
        @opts = opts
        parse()
      end

      private

      def parse()
        if @opts.subcommand_options[:config_given] || @opts.subcommand_options[:info_given]
          print_config(URI(@opts.subcommand_options[:config] || @opts.subcommand_options[:info]))
        end
      end
      #"http://localhost:8080/apimanui/api-manager/orgs/testorg/apis/testapi/1.0/policies/".split("api-manager")[1]
      def print_config(url)
        begin
          target_path = url.path.split("api-manager")[1]
        rescue
          puts "Invalid URL #{split_url}"
          exit(1)
        end

        ui_split_path = target_path.split("/").reject { |e| e.empty? }
        org_name = ui_split_path[1]
        entity_type = ui_split_path[2]
        entity_name = ui_split_path[3]
        entity_version = ui_split_path[4]
        policy_version = ui_split_path[6]

        api_query_path = ["apiman",
          "organizations",
          org_name,
          entity_type,
          entity_name,
          "versions",
          entity_version,
          "policies",
          policy_version
        ]

        constructed_url = "#{url.host}:#{url.port}/#{api_query_path.join("/")}"
        json = JSON.parse(http_get(constructed_url))

        if @opts.subcommand_options[:config_given]
          json = JSON.parse(json["configuration"])
        end

        puts JSON.pretty_generate(json)
      end

      def http_get(url)
        RestClient::get("http://#{@username}:#{@password}@#{url}")
      end
  end
end
