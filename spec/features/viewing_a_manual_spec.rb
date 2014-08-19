require 'rails_helper'

feature "Viewing manuals and sections" do
  # As a member of the public
  # I can view a manual and its sections

  scenario "viewing any manual" do
    visit_manual "employment-income-manual"

    expect_manual_title_to_be("Employment Income Manual")
    expect_manual_update_date_to_be("23 January 2014")

    expect_page_to_include_section("About this manual",
      includes_text: "This manual is a guide to the Income Tax (Earnings and Pensions) Act")

    expect_page_to_include_section("Employment income",
                                   href: "/guidance/employment-income-manual/EIM00500")

    expect_page_to_be_affiliated_with_org(title: "HM Revenue & Customs",
                                          slug: "hm-revenue-customs")
  end

  scenario "viewing a manual section with subsections" do
    visit_manual_section "employment-income-manual", "EIM00500"

    expect_section_title_to_be("Employment income: table of contents")

    expect_page_to_include_section("General",
                                   href: "/guidance/employment-income-manual/EIM00505")
    expect_page_to_include_section("Particular items: A to P",
                                   href: "/guidance/employment-income-manual/EIM01000")

    # breadcrumb
    expect(page).to have_link("Contents",
                              href: "/guidance/employment-income-manual")

    expect_page_to_be_affiliated_with_org(title: "HM Revenue & Customs",
                                          slug: "hm-revenue-customs")
  end

  scenario "visiting a manual section with a body" do
    visit_manual_section "employment-income-manual", "EIM15000"

    # HTML in the body
    expect(page).to have_link("Sections 386-400 ITEPA 2003")
  end

  scenario "HMRC manual section IDs are displayed in the title" do
    visit_manual "employment-income-manual"

    expect_page_to_include_section("EIM00100 About this manual")
    expect_page_to_include_section("EIM00500 Employment income",
                                   href: "/guidance/employment-income-manual/EIM00500")
  end

  scenario "navigating from the manual to a section" do
    visit_manual "employment-income-manual"

    select_section "Accommodation provided by reason of employment"

    expect(current_path).to eq("/guidance/employment-income-manual/EIM11300")
    expect_section_title_to_be("Accommodation provided by reason of employment")
  end

  scenario "visiting a non-existent section" do
    visit_manual_section "employment-income-manual", "nonexistent-manual-section"
    expect(page.status_code).to eq(404)
  end
end
