require 'gds_api/test_helpers/content_store'

module ManualHelpers
  include GdsApi::TestHelpers::ContentStore

  def stub_fake_manual
    manual_json = {
      base_path: "/guidance/my-manual-about-burritos",
      title: "My manual about Burritos",
      description: "Burrito means little donkey",
      format: "manual",
      public_updated_at: "2014-06-20T10:17:29+01:00",
      details: {
        child_section_groups: [
          {
            title: "Contents",
            child_sections: [
              {
                title: "Fillings",
                description: "This section details the fillings.",
                base_path: "/guidance/my-manual-about-burritos/fillings",
              },
              {
                title: "This is the section on hot sauce",
                description: "Hot sauces are good",
                base_path: "/guidance/my-manual-about-burritos/this-is-the-section-on-hot-sauce",
              }
            ]
          }
        ],
        organisations: [
          {
            abbreviation: "CO",
            web_url: "http://www.gov.uk/government/organisations/cabinet-office",
            title: "Cabinet Office",
          }
        ],
        change_notes: [
          {
            base_path: "/guidance/my-manual-about-burritos/fillings",
            title: "Fillings",
            change_note: "Added section on fillings",
            published_at: "2014-06-20T09:17:27Z"
          },
          {
            base_path: "/guidance/my-manual-about-burritos/this-is-the-section-on-hot-sauce",
            title: "This is the section on hot sauce",
            change_note: "Added section on hot sauce",
            published_at: "2014-06-20T09:17:27Z"
          }
        ],
      }
    }

    content_store_has_item("/guidance/my-manual-about-burritos", manual_json)
  end
end

RSpec.configuration.include ManualHelpers
