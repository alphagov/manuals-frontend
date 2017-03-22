require 'rails_helper'

feature "Benchmarking" do
  include GovukAbTesting::RspecHelpers

  scenario "shows the mouseflow tag when in the benchmarking test" do
    stub_education_manual

    with_variant Benchmarking: "B" do
      visit_manual "buying-for-schools"

      expect(page).to have_css("script[src*=mouseflow]", count: 1, visible: :all), "Expected to find one script tag with the mouseflow js code on the page"
    end
  end

  scenario "does not show the mouseflow tag when not in the benchmarking test" do
    stub_education_manual

    with_variant Benchmarking: "A" do
      visit_manual "buying-for-schools"

      expect(page).to_not have_css("script[src*=mouseflow]", visible: :all), "Did not expect to find a script tag with the mouseflow js code on the page"
    end
  end
end
