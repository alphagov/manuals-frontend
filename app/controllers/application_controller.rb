class ApplicationController < ActionController::Base
  include Slimmer::Headers
  include Slimmer::Template

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Slimmer::GovukComponents

  before_action :slimmer_headers

  def show_tasklist_header?
    if defined?(should_show_tasklist_header?)
      should_show_tasklist_header?
    end
  end
  helper_method :show_tasklist_header?

private

  def slimmer_headers
    slimmer_template 'core_layout'
    set_slimmer_headers(remove_search: true)
  end
end
