# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vueapp/version'

Gem::Specification.new do |spec|
  spec.name = 'vueapp'
  spec.version = VueApp::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.3.0'
  spec.authors = ['Alex Merkulov']
  spec.email = ['mercury@bit-forge.org']

  spec.summary = 'Tools for vue.js applications'
  spec.description =
    'Tools for creating and developing vue.js applications easily'
  spec.homepage = 'https://github.com/bit-forge-org/vueapp'
  spec.license = 'MIT'

  spec.files = %w[lib/**/*.rb bin/* lib/vueapp/templates/**/*]
  spec.executables = ['vueapp']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '>= 0.75.0'

  spec.add_dependency 'bundler', '~> 2.1.4'
  spec.add_dependency 'concolor', '0.0.1'
  spec.add_dependency 'listen', '~> 3.2.1'
  spec.add_dependency 'sassc', '~> 2.2.1'
  spec.add_dependency 'slim', '~> 4.0.1'
  spec.add_dependency 'thor', '~> 1.0.1'
  spec.add_dependency 'uglifier', '~> 4.2.0'
end
