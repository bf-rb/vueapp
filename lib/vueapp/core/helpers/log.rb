# frozen_string_literal: true

module VueApp
  module Core
    module Helpers
      # Add log method
      module Log
        # Logger method: puts string with timestamp
        # @param [String] str
        def log(str)
          puts Time.now.strftime('%-d %b %Y [%H:%M:%S]: ').style(:green) + str
        end
      end
    end
  end
end
