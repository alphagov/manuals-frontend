class ApplicationController < ActionController::Base
  include Slimmer::Headers
  include Slimmer::Template

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Slimmer::GovukComponents

  before_action :slimmer_headers

  def current_step_nav
    @step_nav ||= GovukNavigationHelpers::StepNavContent.current_step_nav(request.path)
  end
  helper_method :current_step_nav

  def show_step_nav?
    current_step_nav && current_step_nav.show_step_nav?
  end
  helper_method :show_step_nav?

private

  def slimmer_headers
    slimmer_template 'core_layout'
    set_slimmer_headers(remove_search: true)
  end
end
