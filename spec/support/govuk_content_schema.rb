require 'govuk-content-schema-test-helpers'

GovukContentSchemaTestHelpers.configure do |config|
  config.schema_type = 'frontend'
  config.project_root = Rails.root
end
