class EducationNavigationAbTestRequest
  attr_accessor :requested_variant

  delegate :analytics_meta_tag, to: :requested_variant

  def initialize(request)
    dimension = Rails.application.config.navigation_ab_test_dimension
    ab_test = GovukAbTesting::AbTest.new(
      "EducationNavigation",
      dimension: dimension
    )
    @requested_variant = ab_test.requested_variant(request.headers)
  end

  def should_present_new_navigation_view?(content_item)
    [
      requested_variant.variant_b?,
      new_navigation_enabled?,
      content_is_tagged_to_a_taxon?(content_item)
    ].all?
  end

  def set_response_vary_header(response)
    requested_variant.configure_response(response)
  end

private

  def new_navigation_enabled?
    ENV['ENABLE_NEW_NAVIGATION'] == 'yes'
  end

  def content_is_tagged_to_a_taxon?(content_item)
    content_item.dig("links", "taxons").present?
  end
end
