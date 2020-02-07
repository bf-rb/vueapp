# frozen_string_literal: true

require 'pathname'

require 'thor'
require 'listen'
require 'sassc'
require 'slim'
require 'uglifier'
require 'concolor'

require 'vueapp/version'
require 'vueapp/errors'
require 'vueapp/core/cli/init_helper'
require 'vueapp/core/cli/generator_helper'
require 'vueapp/core/env_helper'
require 'vueapp/core/builder'
require 'vueapp/core/builders/js_builder'
require 'vueapp/core/builders/scss_builder'
require 'vueapp/core/builders/slim_builder'
require 'vueapp/core/listener'
require 'vueapp/cli'

# Base module
module VueApp
  VUEAPP_ROOT = 'vueapp'
  VUEAPP_SRC = 'src'
  VUEAPP_BUILD = 'build'

  module_function

  # Logger method: puts string with timestamp
  # @param [String] str
  def logger(str)
    puts Time.now.strftime('%-d %b %Y [%H:%M:%S]: ').style(:green) + str
  end
end
