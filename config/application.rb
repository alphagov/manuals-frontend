require File.expand_path("boot", __dir__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)

module ManualsFrontend
  class Application < Rails::Application
    config.load_defaults 5.1

    config.eager_load_paths << "#{config.root}/lib"

    # Path within public/ where assets are compiled to
    config.assets.prefix = "/assets/manuals-frontend"

    # allow overriding the asset host with an enironment variable, useful for
    # when router is proxying to this app but asset proxying isn't set up.
    config.asset_host = ENV["ASSET_HOST"]

    # Override Rails 4 default which restricts framing to SAMEORIGIN.
    config.action_dispatch.default_headers = {
      "X-Frame-Options" => "ALLOWALL",
    }

    # Using a sass css compressor causes a scss file to be processed twice
    # (once to build, once to compress) which breaks the usage of "unquote"
    # to use CSS that has same function names as SCSS such as max.
    # https://github.com/alphagov/govuk-frontend/issues/1350
    config.assets.css_compressor = nil
  end
end
