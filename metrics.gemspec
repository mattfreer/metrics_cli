# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metrics/version'

Gem::Specification.new do |spec|
  spec.name          = "metrics"
  spec.version       = Metrics::VERSION
  spec.authors       = ["Matt Freer"]
  spec.email         = ["matt.freer@gmail.com"]
  spec.description   = %q{CLi for an existing machine metrics JSON Web API specification}
  spec.summary       = %q{Given a single argument, which will be the URL of the Web API to use, the CLi outputs a machine metrics summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency('rdoc')
  spec.add_development_dependency('aruba')
  spec.add_development_dependency('rake', '~> 0.9.2')
  spec.add_dependency('methadone', '~> 1.2.6')
  spec.add_dependency('formatador')
  spec.add_dependency('virtus')
  spec.add_dependency('dm-validations')
  spec.add_dependency('ipaddress')

  spec.add_development_dependency('rspec')
end
