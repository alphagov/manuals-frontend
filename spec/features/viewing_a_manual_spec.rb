require 'rails_helper'
require 'gds_api/test_helpers/content_store'

feature "Viewing manuals and sections" do
  # As a member of the public
  # I can view a manual and its sections

  include GdsApi::TestHelpers::ContentStore
  include GovukAbTesting::RspecHelpers

  context "when under TaskListHeader A/B testing" do
    scenario "viewing The Highway Code manual under A variant" do
      stub_fake_manual(base_path: '/guidance/the-highway-code')

      with_variant TaskListHeader: "A" do
        visit_manual('the-highway-code')

        expect(page).to_not have_text('Learn to drive a car: step by step')
      end
    end

    scenario "viewing The Highway Code manual under B variant" do
      stub_fake_manual(base_path: '/guidance/the-highway-code')

      with_variant TaskListHeader: "B" do
        visit_manual('the-highway-code')

        expect(page).to have_text('Learn to drive a car: step by step')
      end
    end
  end

  scenario "viewing any manual" do
    stub_hmrc_manual

    visit_hmrc_manual "inheritance-tax-manual"

    expect_title_tag_to_be('Inheritance Tax Manual - HMRC internal manual - GOV.UK')
    expect_manual_title_to_be("Inheritance Tax Manual")
    expect_manual_update_date_to_be("23 January 2014")
    expect(page.response_headers["Cache-Control"]).to eq("max-age=900, public")

    # This next expectation has been temporarily disabled until inline rendering of leaf
    # sections is implemented
    # expect_page_to_include_section("About this manual",
    #   includes_text: "This manual is a guide to the Income Tax (Earnings and Pensions) Act")

    expect_page_to_include_section("Inheritance tax",
                                   href: "/hmrc-internal-manuals/inheritance-tax-manual/eim00500")

    expect_page_to_be_affiliated_with_org(title: "HM Revenue & Customs",
                                          slug: "hm-revenue-customs")
  end

  scenario "viewing a non-HMRC manual" do
    stub_fake_manual
    visit_manual "my-manual-about-burritos"
    expect_no_component('beta_label')
  end

  scenario "viewing an HMRC manual" do
    stub_hmrc_manual
    visit_hmrc_manual "inheritance-tax-manual"
    expect_component('beta_label')
  end

  scenario "viewing a manual with a description" do
    stub_fake_manual
    visit_manual "my-manual-about-burritos"
    expect(page).to have_selector('meta[name="description"][content="Burrito means little donkey"]', visible: false)
  end

  scenario "viewing a manual section with subsections" do
    stub_hmrc_manual
    stub_hmrc_manual_section_with_subsections

    visit_hmrc_manual_section "inheritance-tax-manual", "eim00500"

    expect_title_tag_to_be('EIM00500 - Inheritance Tax Manual - HMRC internal manual - GOV.UK')
    expect_section_title_to_be("Inheritance tax: table of contents")

    expect_a_child_section_group_title_of("This is a dummy child_section_group title")

    expect_page_to_include_section("Introduction to particular items",
                                   href: "/hmrc-internal-manuals/inheritance-tax-manual/eim00510")
    expect_page_to_include_section("Particular items: A to P",
                                   href: "/hmrc-internal-manuals/inheritance-tax-manual/eim00520")
    expect_page_to_include_section("Particular items: R to Z",
                                   href: "/hmrc-internal-manuals/inheritance-tax-manual/eim00530")

    expect(page.response_headers["Cache-Control"]).to eq("max-age=1200, private")

    # breadcrumb
    expect(page).to have_link("Contents",
                              href: "/hmrc-internal-manuals/inheritance-tax-manual")

    expect_page_to_be_affiliated_with_org(title: "HM Revenue & Customs",
                                          slug: "hm-revenue-customs")

    expect_page_to_contain_navigation_link("Previous page", "/hmrc-internal-manuals/inheritance-tax-manual/eim00100")
    expect_page_to_contain_navigation_link("Next page", "/hmrc-internal-manuals/inheritance-tax-manual/eim00900")
  end

  scenario "viewing a sub-sub section" do
    stub_hmrc_manual
    stub_hmrc_manual_section_with_subsections
    stub_hmrc_manual_sub_sub_section

    visit_hmrc_manual_section "inheritance-tax-manual", "eim00520"

    expect(page).to have_link("Contents",
                              href: "/hmrc-internal-manuals/inheritance-tax-manual")
    expect(page).to have_link("EIM00500",
                              href: "/hmrc-internal-manuals/inheritance-tax-manual/eim00500")

    expect_page_to_contain_navigation_link("Previous page", "/hmrc-internal-manuals/inheritance-tax-manual/eim00510")
    expect_page_to_contain_navigation_link("Next page", "/hmrc-internal-manuals/inheritance-tax-manual/eim00530")
  end

  scenario "visiting a manual section with a body" do
    stub_hmrc_manual
    stub_hmrc_manual_section_with_body

    visit_hmrc_manual_section "inheritance-tax-manual", "eim15000"

    # HTML in the body
    expect_component('govspeak') do |govspeak|
      expect(govspeak).to have_content("Sections 386-400 ITEPA 2003")
    end
  end

  scenario "HMRC manual section IDs are displayed in the title" do
    stub_hmrc_manual
    visit_hmrc_manual "inheritance-tax-manual"

    expect_page_to_include_section("EIM00100 About this manual")
    expect_page_to_include_section("EIM00500 Inheritance tax",
                                   href: "/hmrc-internal-manuals/inheritance-tax-manual/eim00500")
  end

  scenario "navigating from the manual to a section" do
    stub_hmrc_manual
    stub_hmrc_manual_section_with_subsections

    visit_hmrc_manual "inheritance-tax-manual"

    select_section "Inheritance tax"

    expect(current_path).to eq("/hmrc-internal-manuals/inheritance-tax-manual/eim00500")
    expect_section_title_to_be("Inheritance tax")
  end

  scenario "visiting a non-existent section" do
    stub_hmrc_manual
    content_store_does_not_have_item('/hmrc-internal-manuals/inheritance-tax-manual/nonexistent-manual-section')

    visit_hmrc_manual_section "inheritance-tax-manual", "nonexistent-manual-section"
    expect(page.status_code).to eq(404)
  end

  scenario "visiting a withdrawn manual's updates" do
    slug = "/guidance/a-withdrawn-manual"
    stub_withdrawn_manual(slug)

    visit "#{slug}/updates"
    expect(page.status_code).to eq(410)
  end
end
