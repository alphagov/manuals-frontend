class ApplicationController < ActionController::Base
  include Slimmer::Headers
  include Slimmer::Template

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Slimmer::SharedTemplates

  before_filter :slimmer_headers

  helper_method :ab_test
  helper_method :benchmarking_ab_test
  helper_method :should_track_mouse_movements?

  def benchmarking_ab_test
    @benchmarking_ab_test ||= begin
      benchmarking_test = BenchmarkingAbTestRequest.new(request)
      benchmarking_test.set_response_vary_header(response)
      benchmarking_test
    end
  end

  def should_track_mouse_movements?
    benchmarking_ab_test.in_benchmarking?
  end

private

  def slimmer_headers
    slimmer_template 'core_layout'
    set_slimmer_headers(remove_search: true)
  end

  def ab_test
    @ab_test ||= EducationNavigationAbTestRequest.new(request)
  end
end
