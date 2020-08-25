# frozen_string_literal: true

module VueApp
  module Core
    module Helpers
      # Add path helper
      module Path
        VUEAPP_SRC = 'src'
        VUEAPP_BUILD = 'build'

        # Vue app folder path
        # @return [Pathname]
        def app_path
          Pathname.new(Dir.pwd)
        end

        # Vue app build folder path
        # @return [Pathname]
        def build_path
          if development?
            app_path.join(VUEAPP_BUILD, 'development')
          elsif test?
            app_path.join(VUEAPP_BUILD, 'test')
          else
            app_path.join(VUEAPP_BUILD, 'production')
          end
        end

        # Vue app source code path
        # @return [Pathname]
        def src_path
          app_path.join(VUEAPP_SRC)
        end

        # Vue app source vendor path
        # @return [Pathname]
        def src_vendor_path
          src_path.join('_core', 'vendor')
        end

        # Vue app source vendor path
        # @return [Pathname]
        def src_config_path
          src_path.join('config')
        end
      end
    end
  end
end
