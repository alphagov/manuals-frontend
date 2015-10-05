class ApplicationController < ActionController::Base
  include Slimmer::Headers
  include Slimmer::Template

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Slimmer::SharedTemplates

  before_filter :slimmer_headers

  private

  def slimmer_headers
    slimmer_template "header_footer_only"
    set_slimmer_headers(remove_search: true)
  end
end
