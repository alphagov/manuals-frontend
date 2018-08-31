require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module ManualsFrontend
  class Application < Rails::Application
    config.load_defaults 5.1

    config.eager_load_paths << "#{config.root}/lib"

    config.assets.prefix = '/manuals-frontend'

    # Override Rails 4 default which restricts framing to SAMEORIGIN.
    config.action_dispatch.default_headers = {
      'X-Frame-Options' => 'ALLOWALL'
    }
  end
end
