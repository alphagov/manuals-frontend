class ApplicationController < ActionController::Base
  include Slimmer::Headers
  include Slimmer::Template

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Slimmer::GovukComponents

  before_filter :slimmer_headers

  helper_method :ab_test

private

  def slimmer_headers
    slimmer_template 'core_layout'
    set_slimmer_headers(remove_search: true)
  end

  def ab_test
    @ab_test ||= EducationNavigationAbTestRequest.new(request)
  end
end
