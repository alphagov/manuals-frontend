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

  def stub_hmrc_manual
    manual_json = {
      base_path: "/guidance/inheritance-tax-manual",
      title: "Inheritance Tax Manual",
      description: nil,
      format: "manual",
      public_updated_at: "2014-01-23T00:00:00+01:00",
      details: {
        child_section_groups: [
          {
            title: nil,
            child_sections: [
              {
                section_id: "EIM00100",
                base_path: "/guidance/inheritance-tax-manual/eim00100",
                title: "About this manual",
              },
              {
                section_id: "EIM00500",
                base_path: "/guidance/inheritance-tax-manual/eim00500",
                title: "Inheritance tax",
              },
            ]
          }
        ],
        organisations: [
          {
            abbreviation: "HMRC",
            web_url: "http://www.gov.uk/government/organisations/hm-revenue-customs",
            title: "HM Revenue & Customs",
          }
        ],
        change_notes: [],
      }
    }

    content_store_has_item("/guidance/inheritance-tax-manual", manual_json)
  end

  def stub_hmrc_manual_section_with_subsections
    section_json = {
      base_path: "/guidance/inheritance-tax-manual/eim00500",
      title: "Inheritance tax: table of contents",
      description: nil,
      format: "manual-section",
      public_updated_at: "2014-01-23T00:00:00+01:00",
      details: {
        body: nil,
        section_id: "eim00500",
        child_section_groups: [
          {
            title: nil,
            child_sections: [
              {
                section_id: "EIM00505",
                base_path: "/guidance/inheritance-tax-manual/eim00505",
                title: "General",
              },
              {
                section_id: "EIM01000",
                base_path: "/guidance/inheritance-tax-manual/eim01000",
                title: "Particular items: A to P",
              },
            ]
          }
        ]
      }
    }

    content_store_has_item("/guidance/inheritance-tax-manual/eim00500", section_json)
  end

  def stub_hmrc_manual_section_with_body
    section_json = {
      base_path: "/guidance/inheritance-tax-manual/eim15000",
      title: "Parent-financed and non-approved retirement benefits schemes: table of contents",
      description: nil,
      format: "manual-section",
      public_updated_at: "2014-01-23T00:00:00+01:00",
      details: {
        body: 'On this page:<br><br><a href="/guidance/inheritance-tax-manual/EIM15000#EIM15010#IDAZR1YH">Sections 386-400 ITEPA 2003]</a><br>',
        section_id: "eim15000",
        child_section_groups: []
      }
    }

    content_store_has_item("/guidance/inheritance-tax-manual/eim15000", section_json)
  end
end

RSpec.configuration.include ManualHelpers
