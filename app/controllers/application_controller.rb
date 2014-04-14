class ApplicationController < ActionController::Base
  include Slimmer::Headers

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :slimmer_headers

  private

  def slimmer_headers
    set_slimmer_headers(template: "header_footer_only")
  end

end
