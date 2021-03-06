# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jockey_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "jockey_cli"
  spec.version       = JockeyCli::VERSION
  spec.authors       = ["Darby Frey"]
  spec.email         = ["darby@bellycard.com"]
  spec.summary       = %q{API Wrapper and CLI for Jockey}
  spec.description   = %q{API Wrapper and CLI for Jockey API}
  spec.homepage      = "https://github.com/bellycard/jockey_cli"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }

  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty', '~> 0.13'
  spec.add_dependency 'hashie', '~> 3.3'
  spec.add_dependency 'thor', '~> 0.19'
  spec.add_dependency 'git', '~> 1.2'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'pry', '~> 0.10.1'
  spec.add_development_dependency 'rspec', '~> 3.1'
end
