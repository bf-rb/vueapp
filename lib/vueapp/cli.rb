# frozen_string_literal: true

module VueApp
  # Console client for vueapp
  class CLI < Thor
    include Thor::Actions
    include VueApp::Core::CLI::InitHelper
    include VueApp::Core::CLI::BuildHelper
    include VueApp::Core::CLI::GeneratorHelper

    no_commands do
      # Define source paths
      def source_paths
        ["#{__dir__}/templates"]
      end
    end

    desc 'init', 'initialize [VUEAPP] in current folder'
    def init
      run_init
    end

    desc 'dev', 'run rebuild tool'
    def dev
      VueApp::Core::Builder.build(:development)
      VueApp::Core::Listener.call
    end

    desc 'build [env]', 'build vueapp'
    def build(env = 'development')
      run_build(env&.to_sym)
    end

    desc 'g [type] [name]', 'generate'
    def g(type, name)
      case type
      when 'component'
        generate_component(name)
      else
        help
      end
    end
  end
end
