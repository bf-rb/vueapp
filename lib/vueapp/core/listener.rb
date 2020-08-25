# frozen_string_literal: true

module VueApp
  module Core
    # Listen file modification
    class Listener
      include VueApp::Core::Helpers::Log

      # Base class method
      def self.call
        new.run
      end

      # Listener main method
      def run
        log('Run Listener: ' + vueapp_path)
        slim_listener
        js_listener
        scss_listener
        sleep
      end

      private

      # Listener for .slim files
      def slim_listener
        listener = Listen.to(vueapp_path, only: /.slim$/) do |modified, added, removed|
          log("Modified: #{modified}") if modified
          log("Added: #{added}") if added
          log("Removed: #{removed}") if removed
          VueApp::Core::Builders::SlimBuilder.new(:development).build
        end
        listener.start
      end

      # Listener for .js files
      def js_listener
        listener = Listen.to(vueapp_path, only: /.js$/) do |modified, added, removed|
          log("Modified: #{modified}") if modified
          log("Added: #{added}") if added
          log("Removed: #{removed}") if removed
          VueApp::Core::Builders::JsBuilder.new(:development).build
        end
        listener.start
      end

      # Listener for .scss files
      def scss_listener
        listener = Listen.to(vueapp_path, only: /.scss$/) do |modified, added, removed|
          log("Modified: #{modified}") if modified
          log("Added: #{added}") if added
          log("Removed: #{removed}") if removed
          VueApp::Core::Builders::ScssBuilder.new(:development).build
        end
        listener.start
      end

      # Path for listener
      def vueapp_path
        Pathname.new(Dir.pwd).join('src').to_s
      end
    end
  end
end
