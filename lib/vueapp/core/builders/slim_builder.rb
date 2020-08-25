# frozen_string_literal: true

module VueApp
  module Core
    module Builders
      # Slim builder
      class SlimBuilder < VueApp::Core::Builder
        include VueApp::Core::Helpers::Env
        include VueApp::Core::Helpers::Timer
        include VueApp::Core::Helpers::Path
        include VueApp::Core::Helpers::Build

        # Create a Slim builder for a specific environment
        # @param [Symbol] env
        # @raise [VueApp::Errors::InvalidENV]
        def initialize(env = :development)
          init_env(env)
        end

        # Render components slim template
        # @return [String]
        def render_components
          components = ''
          slim_files.each do |slim_file|
            components += if development?
                            Slim::Template.new(slim_file, pretty: true).render
                          else
                            Slim::Template.new(slim_file).render
                          end
          end
          components
        end

        private

        def build_dev
          timer_block(
            'Start [development] build for *.slim files',
            'SLIM time: '
          ) do
            File.open(index_file, 'w') do |file|
              file.write(
                Slim::Template.new(base_layout, pretty: true).render(self)
              )
            end
          end
        end

        def build_production
          timer_block(
            'Start [production] build for *.slim files',
            'SLIM time: '
          ) do
            File.open(index_file, 'w') do |file|
              file.write(
                Slim::Template.new(base_layout).render(self)
              )
            end
          end
        end

        # Base layout filepath
        # @return [Pathname]
        def base_layout
          src_path.join('index.slim')
        end

        # Index html filename
        # @return [Pathname]
        def index_file
          build_path.join('index.html')
        end

        # All *.slim files from [components] folder
        # @return [Array<String>] all [*.slim] files
        def components_slim
          Dir[src_path.join('components', '**', '*.slim').to_s]
        end

        # All *.slim files from [pages] folder
        # @return [Array<String>] all [*.slim] files
        def pages_slim
          Dir[src_path.join('pages', '**', '*.slim').to_s]
        end

        # Get all [*.slim] file in the app path
        # @return [Array<String>] all [*.slim] files
        def slim_files
          components_slim + pages_slim
        end
      end
    end
  end
end
