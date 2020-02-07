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
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
  #   `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # end

  spec.files = %w[lib/**/*.rb bin/*]
  # spec.bindir        = 'exe'
  spec.executables = ['vueapp']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '>= 0.75.0'

  spec.add_dependency 'bundler', '~> 2.0'
  spec.add_dependency 'concolor', '0.0.1'
  spec.add_dependency 'listen', '~> 3.2'
  spec.add_dependency 'sassc'
  spec.add_dependency 'slim', '~> 4.0', '>= 4.0.1'
  spec.add_dependency 'thor', '~> 0.20.3'
  spec.add_dependency 'uglifier', '~> 4.2.0'
end
