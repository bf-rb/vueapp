# frozen_string_literal: true

module VueApp
  module Core
    # Add @env to obj
    module EnvHelper
      ENV_LIST = %I[development production test].freeze

      # Initialize @env
      # @param [Symbol] env
      def init_env(env)
        raise VueApp::Errors::InvalidENV unless ENV_LIST.include?(env)

        @env = env
      end

      # True if @env == :development
      # @return [TrueClass,FalseClass]
      def development?
        env_is_a?(:development)
      end

      # True if @env == :production
      # @return [TrueClass,FalseClass]
      def production?
        env_is_a?(:production)
      end

      # True if @env == :test
      # @return [TrueClass,FalseClass]
      def test?
        env_is_a?(:test)
      end

      private

      # Detect env
      # @param [Symbol] env
      # @return [TrueClass,FalseClass]
      def env_is_a?(env)
        @env.eql?(env)
      end
    end
  end
end
