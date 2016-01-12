# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apiman/diagnostics/version'

Gem::Specification.new do |spec|
  spec.name          = "apiman-diagnostics"
  spec.version       = Apiman::Diagnostics::VERSION
  spec.authors       = ["Marc Savy"]
  spec.email         = ["marc@rhymewithgravy.com"]
  spec.license       = "Apache-2.0"

  spec.summary       = %q{Some helpful commands to run against apiman's manager API, principally for debugging. Most commands allow you to paste a UI URL}
  spec.homepage      = "http://www.apiman.io"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_runtime_dependency "rest-client", "~> 1.8"
  spec.add_runtime_dependency "trollop", "~> 2.1"
  spec.add_runtime_dependency "trollop-subcommands", "0.1.0"
end
