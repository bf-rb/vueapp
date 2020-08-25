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
require 'vueapp/core/helpers/log'
require 'vueapp/core/helpers/env'
require 'vueapp/core/helpers/timer'
require 'vueapp/core/helpers/path'
require 'vueapp/core/helpers/build'
require 'vueapp/core/cli/init_helper'
require 'vueapp/core/cli/build_helper'
require 'vueapp/core/cli/generator_helper'
require 'vueapp/core/builder'
require 'vueapp/core/builders/js_builder'
require 'vueapp/core/builders/scss_builder'
require 'vueapp/core/builders/slim_builder'
require 'vueapp/core/listener'
# require 'vueapp/cli'

# Base module
module VueApp
  autoload :CLI, 'vueapp/cli'
end
