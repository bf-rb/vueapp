# frozen_string_literal: true

module VueApp
  module Core
    # Base Vue app builder
    class Builder
      include VueApp::Core::Helpers::Env
      include VueApp::Core::Helpers::Log
      include VueApp::Core::Helpers::Timer

      # Create a builder for a specific environment
      # @param [Symbol] env
      # @raise [VueApp::Errors::InvalidENV]
      def initialize(env = :development)
        init_env(env)
        @js_builder = VueApp::Core::Builders::JsBuilder.new(env)
        @scss_builder = VueApp::Core::Builders::ScssBuilder.new(env)
        @slim_builder = VueApp::Core::Builders::SlimBuilder.new(env)
      end

      # Build [VUEAPP] use [@env]
      def build
        timer_block "Start [#{@env}] build", 'End build: ' do
          @js_builder.build
          @scss_builder.build
          @slim_builder.build
        end
      end

      # Base method for build Vue app
      # @param [Symbol] env
      def self.build(env)
        Builder.new(env).build
      end
    end
  end
end
