# frozen_string_literal: true

module VueApp
  module Core
    # Base Vue app builder
    module CLI
      # Helper for CLI
      module GeneratorHelper
        def component_name
          args.last
        end

        def generate_component(name)
          component_path = src_path('components/' + name)
          VueApp.logger('Generate component: ' + name)
          template('generators/component/new.js', "#{component_path}/#{name}.js")
          template('generators/component/new.slim', "#{component_path}/#{name}.slim")
          template('generators/component/new.scss', "#{component_path}/#{name}.scss")
        end
      end
    end
  end
end
