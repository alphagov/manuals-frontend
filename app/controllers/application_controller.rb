class ApplicationController < ActionController::Base
  include Slimmer::Headers

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :slimmer_headers
  before_filter :set_alpha_header
  before_filter :set_robots_headers

  private

  def slimmer_headers
    set_slimmer_headers(template: "header_footer_only")
  end

  def set_alpha_header
    response.headers[Slimmer::Headers::ALPHA_LABEL] = "before:#manuals-frontend header"
  end

  def set_robots_headers
    response.headers["X-Robots-Tag"] = "none"
  end

end
