# frozen_string_literal: true

module VueApp
  module Core
    module Builders
      # Build one javascript file
      class JsBuilder
        include VueApp::Core::Helpers::Env
        include VueApp::Core::Helpers::Log
        include VueApp::Core::Helpers::Timer
        include VueApp::Core::Helpers::Path
        include VueApp::Core::Helpers::Build

        # Create a JS builder for a specific environment
        # @param [Symbol] env
        # @raise [VueApp::Errors::InvalidENV]
        def initialize(env = :development)
          init_env(env)
        end

        private

        # Build dev js file
        def build_dev
          timer_block(
            'Start [development] build for *.js files',
            'JS time: ') do
            all_js_into_one_file
          end
        end

        def build_production
          timer_block(
            'Start [production] build for *.js files',
            'JS time: ') do
            all_js_into_one_file
            compress_min_js
          end
        end

        # Vue.js
        def vue_js
          if development?
            src_vendor_path.join('vue.dev.js').to_s
          else
            src_vendor_path.join('vue.js').to_s
          end
        end

        # Vue.js and required libs
        # @return [Array<String>]
        def vue_lib_js
          [vue_js, src_vendor_path.join('vue_router.js').to_s]
        end

        # All *.js files from [mixins] folder
        # @return [Array<String>]
        def mixins_js
          Dir[src_path.join('mixins', '**', '*.js').to_s]
        end

        # All *.js files from [filters] folder
        # @return [Array<String>]
        def filters_js
          Dir[src_path.join('filters', '**', '*.js').to_s]
        end

        # All *.js files from [components] folder
        # @return [Array<String>]
        def components_js
          Dir[src_path.join('components', '**', '*.js').to_s]
        end

        # All *.js files from [pages] folder
        # @return [Array<String>]
        def pages_js
          Dir[src_path.join('pages', '**', '*.js').to_s]
        end

        # All *.js files from [config] folder
        # @return [Array<String>]
        def config_js
          [
            src_config_path.join('routes.js').to_s,
            src_config_path.join('router.js').to_s,
            src_config_path.join('app.js').to_s
          ]
        end

        # Get all [*.js] file in the app path (ordered)
        # @return [Array<String>] all [*.js] files
        def js_files
          [
            vue_lib_js, mixins_js, filters_js, components_js,
            pages_js, config_js
          ].flatten!
        end

        # Base js filename
        # @return [Pathname]
        def base_js_file
          build_path.join('scripts.js')
        end

        # Minified base js filename
        # @return [Pathname]
        def min_js_file
          build_path.join('scripts.min.js')
        end

        # Get compressor object
        # @return [Uglifier]
        def compressor
          Uglifier.new(harmony: true)
        end

        # Merge all *.js files into one file
        def all_js_into_one_file
          File.open(base_js_file, 'w') do |file|
            js_files.each do |js_file|
              file.write('/* file: ' + js_file + " */\n") if development?
              file.write(File.read(js_file))
            end
          end
        end

        # Compress and minify js file
        def compress_min_js
          File.open(min_js_file, 'w') do |file|
            file.write(
              compressor.compile(File.read(base_js_file))
            )
          end
          FileUtils.mv(min_js_file, base_js_file)
          FileUtils.remove_file(min_js_file, true)
        end
      end
    end
  end
end
