require 'gds_api/test_helpers/content_api'

module ManualHelpers
  include GdsApi::TestHelpers::ContentApi

  def stub_fake_manual
    manual_json = {
      id: "http://contentapi.dev.gov.uk/guidance%2Fmy-manual-about-burritos.json",
      web_url: "/guidance/my-manual-about-burritos",
      title: "My manual about Burritos",
      format: "manual",
      updated_at: "2014-06-20T10:17:29+01:00",
      tags: [
        {
          id: "http://contentapi.dev.gov.uk/tags/organisation/cabinet-office.json",
          slug: "cabinet-office",
          web_url: "http://www.dev.gov.uk/government/organisations/cabinet-office",
          title: "Cabinet Office",
          details: {
            type: "organisation"
          },
          content_with_tag: {
            id: "http://contentapi.dev.gov.uk/with_tag.json?organisation=cabinet-office",
          },
        }
      ],
      details: {
        business_proposition: false,
        language: "en",
        need_extended_font: false,
        summary: "Burrito means little donkey",
        section_groups: [
          {
            title: "Contents",
            sections: [
              {
                title: "Fillings",
                summary: "This section details the fillings.",
                slug: "guidance/my-manual-about-burritos/fillings"
              },
              {
                title: "This is the section on hot sauce",
                summary: "Hot sauces are good",
                slug: "guidance/my-manual-about-burritos/this-is-the-section-on-hot-sauce"
              }
            ]
          }
        ]
      }
    }

    content_api_has_an_artefact("guidance/my-manual-about-burritos", manual_json)
  end

  def stub_fake_manual_updates
    updates_json = {
      id: "http://contentapi.dev.gov.uk/guidance%2Fmy-manual-about-burritos%2Fupdates.json",
      web_url: "/guidance/my-manual-about-burritos/updates",
      title: "Updates: My manual about Burritos",
      format: "manual-change-history",
      updated_at: "2014-06-20T10:17:31+01:00",
      tags: [
        {
          id: "http://contentapi.dev.gov.uk/tags/organisation/cabinet-office.json",
          slug: "cabinet-office",
          web_url: "http://www.dev.gov.uk/government/organisations/cabinet-office",
          title: "Cabinet Office",
          details: {
            type: "organisation"
          },
          content_with_tag: {
            id: "http://contentapi.dev.gov.uk/with_tag.json?organisation=cabinet-office",
          },
        }
      ],
      details: {
        business_proposition: false,
        language: "en",
        need_extended_font: false,
        updates: [
          {
            slug: "guidance/my-manual-about-burritos/fillings",
            title: "Fillings",
            change_note: "Added section on fillings",
            published_at: "2014-06-20T09:17:27Z"
          },
          {
            slug: "guidance/my-manual-about-burritos/this-is-the-section-on-hot-sauce",
            title: "This is the section on hot sauce",
            change_note: "Added section on hot sauce",
            published_at: "2014-06-20T09:17:27Z"
          }
        ],
        manual_slug: "guidance/my-manual-about-burritos"
      }
    }
    content_api_has_an_artefact("guidance/my-manual-about-burritos/updates", updates_json)
  end
end

RSpec.configuration.include ManualHelpers
