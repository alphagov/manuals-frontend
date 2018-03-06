class ApplicationController < ActionController::Base
  include Slimmer::Headers
  include Slimmer::Template

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Slimmer::GovukComponents

  before_action :slimmer_headers

  def step_nav_helper
    @step_nav_helper ||= GovukPublishingComponents::StepNavHelper.new(content_store_manual,
      request.path)
  end
  helper_method :step_nav_helper

private

  def slimmer_headers
    slimmer_template 'core_layout'
    set_slimmer_headers(remove_search: true)
  end
end
