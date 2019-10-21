class ApplicationController < ActionController::Base
  include Slimmer::Headers
  include Slimmer::Template

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from GdsApi::HTTPForbidden, with: :error_403

  before_action :slimmer_headers

  if ENV["BASIC_AUTH_USERNAME"]
    http_basic_authenticate_with(
      name: ENV.fetch("BASIC_AUTH_USERNAME"),
      password: ENV.fetch("BASIC_AUTH_PASSWORD"),
    )
  end

private

  def error_403
    render status: :forbidden, plain: "403 forbidden"
  end

  def slimmer_headers
    slimmer_template "core_layout"
    set_slimmer_headers(remove_search: true)
  end
end
