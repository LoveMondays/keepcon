# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'keepcon/version'

Gem::Specification.new do |spec|
  spec.name          = 'keepcon'
  spec.version       = Keepcon::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Shane O'Grady"]
  spec.email         = ['shane@ogrady.ie']

  spec.summary       = 'Ruby wrapper for the Keepcon XML API'
  spec.homepage      = 'https://github.com/LoveMondays/keepcon'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin/) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)/)
  spec.require_paths = ['lib']

  spec.add_dependency 'retryable-rb'
  spec.add_dependency 'faraday'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'actionview'
  spec.add_dependency 'gyoku'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
