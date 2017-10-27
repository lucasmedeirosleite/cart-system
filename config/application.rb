# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module CartSystem
  class Application < Rails::Application
    config.load_defaults 5.1

    config.autoload_paths += %W[#{config.root}/app/repositories
                                #{config.root}/app/services}]

    config.generators.system_tests = nil
  end
end
