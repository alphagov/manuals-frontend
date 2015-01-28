require 'rails_helper'

feature "Viewing updates for a manual" do
  # As a member of the public
  # I can view updates for a manual

  before do
    stub_fake_manual
  end

  scenario "viewing change notes for a manual" do
    visit_manual "my-manual-about-burritos"
    view_manual_change_notes
    expect_title_tag_to_be('Updates - My manual about Burritos - Guidance - GOV.UK')
    expect(page).to have_content("Updates: My manual about Burritos")
  end

  scenario "viewing change notes for an HMRC manual" do
    stub_hmrc_manual

    visit_hmrc_manual "inheritance-tax-manual"
    view_manual_change_notes
    expect_title_tag_to_be('Updates - Inheritance Tax Manual - HMRC internal manual - GOV.UK')
  end

  scenario "viewing change notes for a specific date", js: true do
    visit_manual "my-manual-about-burritos"
    view_manual_change_notes

    view_change_notes_for("20 June 2014")

    expect_change_note("Added section on fillings",
                       section_title: "Fillings",
                       section_href: "/guidance/my-manual-about-burritos/fillings")
    expect_change_note("Added section on hot sauce",
                       section_title: "This is the section on hot sauce",
                       section_href: "/guidance/my-manual-about-burritos/this-is-the-section-on-hot-sauce")
  end
end
