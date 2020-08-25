# frozen_string_literal: true

module VueApp
  module Core
    module CLI
      # Helper for CLI [vueapp init]
      module InitHelper
        # Run initialization
        def run_init
          ask_text = "Do you want to initialize [VUEAPP]\n"
          ask_text += 'in folder: [' + app_path('') + ']?(yes/no):'
          return unless yes?(ask_text, :green)

          empty_directory(app_path('build/development'))
          empty_directory(app_path('build/production'))
          empty_directory(app_path('build/test'))
          init_core_folder
          init_src_folder
          init_config_folder
          init_pages_folder
        end

        # Get VUEAPP root path
        # @param [String] path
        # @return [String]
        def app_path(path)
          File.expand_path(path, Dir.pwd)
        end

        # Get VUEAPP src path
        # @param [String] path
        # @return [String]
        def src_path(path)
          app_path('src/' + path)
        end

        # Get VUEAPP src/_core/vendor path
        # @param [String] path
        # @return [String]
        def src_vendor_path(path)
          app_path('src/_core/vendor/' + path)
        end

        # Copy all core files
        def init_core_folder
          copy_file('_core/vendor/vue.js', src_vendor_path('vue.js'))
          copy_file('_core/vendor/vue.dev.js', src_vendor_path('vue.dev.js'))
          copy_file(
            '_core/vendor/vue_router.js',
            src_vendor_path('vue_router.js')
          )
        end

        # Create src folders
        def init_src_folder
          copy_file('index.slim', src_path('index.slim'))
          copy_file('styles.scss', src_path('styles.scss'))
          empty_directory(src_path('mixins'))
          empty_directory(src_path('filters'))
          empty_directory(src_path('components'))
        end

        def init_pages_folder
          copy_file('pages/home/home.js', src_path('pages/home/home.js'))
          copy_file('pages/home/home.scss', src_path('pages/home/home.scss'))
          copy_file('pages/home/home.slim', src_path('pages/home/home.slim'))
          copy_file('pages/about_us/about_us.js', src_path('pages/about_us/about_us.js'))
          copy_file('pages/about_us/about_us.scss', src_path('pages/about_us/about_us.scss'))
          copy_file('pages/about_us/about_us.slim', src_path('pages/about_us/about_us.slim'))
        end

        # Copy config folder files
        def init_config_folder
          copy_file('config/app.js', src_path('config/app.js'))
          copy_file('config/routes.js', src_path('config/routes.js'))
          copy_file('config/router.js', src_path('config/router.js'))
        end
      end
    end
  end
end
