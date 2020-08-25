# frozen_string_literal: true

module VueApp
  module Core
    module Helpers
      # Add build method related to @env
      module Build
        # Build method
        # @param [String] str
        def build
          case @env
          when :production then build_production
          when :development then build_dev
          when :test then build_test
          else
            build_dev
          end
        end
      end
    end
  end
end
