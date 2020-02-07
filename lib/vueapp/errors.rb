# frozen_string_literal: true

module VueApp
  module Errors
    class Error < StandardError; end
    class InvalidENV < Error; end
  end
end
