require 'rails_helper'

feature "Viewing a manual" do
  # As a member of the public
  # I can view a manual and its sections

  scenario "viewing an existing manual" do
    visit_manual("employment-income-manual")
    select_section("EIM00500")
    expect(page).to have_content("EIM00500 - Employment income")
  end

  scenario "visiting a non-existent section" do
    visit "/guidance/employment-income-manual/nonexistent-manual-section"
    expect(page.status_code).to eq(404)
  end

  scenario "providing a form for reporting problems" do
    visit_manual("employment-income-manual")
    expect(page).to have_selector("#test-report_a_problem")
  end
end
