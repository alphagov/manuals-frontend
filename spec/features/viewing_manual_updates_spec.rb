require 'rails_helper'

feature "Viewing updates for a manual" do
  # As a member of the public
  # I can view updates for a manual

  before do
    stub_fake_manual
    stub_fake_manual_updates
  end

  scenario "viewing updates for a manual" do
    visit "/guidance/my-manual-about-burritos"
    click_on "See all updates"
    expect(page).to have_content("Updates: My manual about Burritos")
  end

  scenario "viewing a specific update", js: true do
    visit "/guidance/my-manual-about-burritos"
    click_on "See all updates"
    page.find(".js-subsection-title", text: "20 June 2014").click
    expect(page).to have_content("Added section on fillings")
  end
end
