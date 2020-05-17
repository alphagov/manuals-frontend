require "rails_helper"
require "gds_api/test_helpers/content_store"

feature "Viewing manuals and sections examples from govuk-content-schemas" do
  include GdsApi::TestHelpers::ContentStore

  describe "support for example manuals" do
    it "should render a page including the manual title" do
      examples_for_formats(%w[manual hmrc_manual]).each do |example_json|
        content_item = JSON.parse(example_json)
        stub_content_store_has_item(content_item["base_path"], content_item)

        visit content_item["base_path"]

        expect(page.status_code).to eq(200)
        expect_manual_title_to_be(content_item["title"])
      end
    end
  end

  describe "support for example manual sections" do
    it "should render a page including the section title" do
      # Assumption that there is an example manual relating to every example section
      examples_for_formats(%w[manual hmrc_manual]).each do |example_json|
        content_item = JSON.parse(example_json)
        stub_content_store_has_item(content_item["base_path"], content_item)
      end

      examples_for_formats(%w[manual_section hmrc_manual_section]).each do |example_json|
        content_item = JSON.parse(example_json)
        stub_content_store_has_item(content_item["base_path"], content_item)

        visit content_item["base_path"]

        expect(page.status_code).to eq(200)
        expect_section_title_to_be(content_item["title"])
      end
    end
  end
end
