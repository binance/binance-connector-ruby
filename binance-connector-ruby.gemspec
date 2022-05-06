# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'binance/version'

Gem::Specification.new do |spec|
  spec.name          = 'binance-connector-ruby'
  spec.version       = Binance::VERSION
  spec.authors       = ['Binance']

  spec.summary       = 'This is a lightweight library that works as a connector to the Binance public API.'
  spec.description   = ''
  spec.homepage      = 'https://github.com/binance/binance-connector-ruby'
  spec.license       = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['documentation_uri'] = 'https://binance-docs.github.io/apidocs/spot/en/'
  spec.metadata['source_code_uri'] = 'https://github.com/binance/binance-connector-ruby'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").select do |file|
      file.match(%r{^(lib/*|README|LICENSE|CHANGELOG)})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5.0'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'gem-release', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_runtime_dependency 'faraday', '~> 1.8'
  spec.add_runtime_dependency 'websocket-eventmachine-client', '~> 1.3'
end
