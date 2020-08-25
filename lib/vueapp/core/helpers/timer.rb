# frozen_string_literal: true

module VueApp
  module Core
    module Helpers
      # Add timer_block method
      module Timer
        # Time counter
        def timer_block(start_text, end_text, &block)
          start_time = Time.now
          log(start_text)
          block.call(self)
          end_time = (Time.now - start_time).round(2)
          log(end_text + end_time.to_s + 's')
        end
      end
    end
  end
end
