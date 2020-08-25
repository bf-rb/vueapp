# frozen_string_literal: true

module VueApp
  module Core
    module CLI
      # Helper for CLI [vueapp build]
      module BuildHelper
        # Run builders
        # @param [Symbol] env
        def run_build(env)
          ask_text = "Do you want to build [VUEAPP] in ["
          ask_text += env.to_s + '] mode?(yes/no):'
          return unless yes?(ask_text, :green)

          VueApp::Core::Builder.build(env)
        end
      end
    end
  end
end
