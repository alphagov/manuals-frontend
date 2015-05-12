require 'govuk-content-schema-test-helpers'

GovukContentSchemaTestHelpers.configure do |config|
  config.schema_type = 'frontend'
  config.project_root = Rails.root
end

module GovukContentSchemaExamples
  def examples_for_formats(formats)
    GovukContentSchemaTestHelpers::Examples.new.get_all_for_formats(formats)
  end
end

RSpec.configuration.include GovukContentSchemaExamples
