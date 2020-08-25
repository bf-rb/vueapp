# frozen_string_literal: true

module VueApp
  module Core
    module Builders
      # SCSS builder
      class ScssBuilder < VueApp::Core::Builder
        include VueApp::Core::Helpers::Env
        include VueApp::Core::Helpers::Timer
        include VueApp::Core::Helpers::Path
        include VueApp::Core::Helpers::Build

        # Create a SCSS builder for a specific environment
        # @param [Symbol] env
        # @raise [VueApp::Errors::InvalidENV]
        def initialize(env = :development)
          init_env(env)
        end

        private

        def build_dev
          timer_block(
            'Start [development] build for *.scss files',
            'CSS time: ') do
            all_scss_into_one_file
            compress_css
          end
        end

        def build_production
          timer_block(
            'Start [production] build for *.scss files',
            'CSS time: ') do
            all_scss_into_one_file
            compress_min_css
          end
        end

        # Base css filename
        # @return [Pathname]
        def base_css_file
          build_path.join('styles.css')
        end

        # Base scss filename
        # @return [Pathname]
        def base_scss_file
          build_path.join('styles.scss')
        end

        # Base scss file
        #  @return [String]
        def styles_scss
          src_path.join('styles.scss').to_s
        end

        # All *.scss files from [components] folder
        # @return [Array<String>] all [*.scss] files
        def components_scss
          Dir[src_path.join('components', '**', '*.scss').to_s]
        end

        # All *.scss files from [pages] folder
        # @return [Array<String>] all [*.scss] files
        def pages_scss
          Dir[src_path.join('pages', '**', '*.scss').to_s]
        end

        # Get all [*.scss] file in the app path
        # @return [Array<String>] all [*.scss] files
        def sass_files
          [
            styles_scss, components_scss, pages_scss
          ].flatten!
        end

        # Merge all *.scss files into one file
        def all_scss_into_one_file
          File.open(base_scss_file, 'w') do |file|
            sass_files.each do |sass_file|
              file.write("/* file:  #{sass_file} */\n") if development?
              file.write(File.read(sass_file))
            end
          end
        end

        # Compress and minify scss file
        def compress_min_css
          File.open(base_css_file, 'w') do |file|
            file.write(
              SassC::Engine.new(
                File.read(base_scss_file), style: :compressed
              ).render
            )
          end
          FileUtils.remove_file(base_scss_file, true)
        end

        # Compress scss file
        def compress_css
          File.open(base_css_file, 'w') do |file|
            file.write(
              SassC::Engine.new(
                File.read(base_scss_file), style: :expanded
              ).render
            )
          end
          FileUtils.remove_file(base_scss_file, true)
        end
      end
    end
  end
end
