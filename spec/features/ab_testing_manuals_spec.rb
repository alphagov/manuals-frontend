require 'rails_helper'
require 'climate_control'

feature "Viewing manuals and sections" do
  include GovukAbTesting::RspecHelpers

  around(:each) do |example|
    ClimateControl.modify(ENABLE_NEW_NAVIGATION: 'yes') do
      example.run
    end
  end

  scenario "viewing a manual with the new navigation" do
    stub_education_manual

    with_variant EducationNavigation: 'B' do
      visit_manual "buying-for-schools"

      expect_component('beta_label')

      expect_component('breadcrumbs') do |breadcrumb_data|
        breadcrumbs = breadcrumb_data['breadcrumbs']

        expect(breadcrumbs.count).to eq(3)
        expect(breadcrumbs).to include("title" => "Home", "url" => "/")
        expect(breadcrumbs).to include(
          "title" => "Education, training and skills",
          "url" => "/education"
        )
        expect(breadcrumbs.last['title']).to match(
          /buying for schools/i
        )
        expect(breadcrumbs.last['is_current_page']).to be_truthy
      end
    end
  end

  scenario "viewing a manual section with the new navigation" do
    stub_education_manual
    stub_education_manual_section

    with_variant EducationNavigation: 'B' do
      visit_manual "buying-for-schools"
      select_section "1. Plan your procurement process"

      expect_component('beta_label')

      expect_component('breadcrumbs') do |breadcrumb_data|
        breadcrumbs = breadcrumb_data['breadcrumbs']
        expect(breadcrumbs.count).to eq(4)
        expect(breadcrumbs).to include("title" => "Home", "url" => "/")
        expect(breadcrumbs).to include(
          "title" => "Education, training and skills",
          "url" => "/education"
        )
        expect(breadcrumbs).to include(
          "title" => "Buying for schools",
          "url" => "/guidance/buying-for-schools"
        )
        expect(breadcrumbs.last['title']).to match(
          /1\. plan your procurement process/i
        )
        expect(breadcrumbs.last['is_current_page']).to be_truthy
      end
    end
  end

  scenario "viewing change notes for a manual with the new navigation" do
    stub_education_manual

    with_variant EducationNavigation: 'B' do
      visit_manual "buying-for-schools"
      view_manual_change_notes

      expect_component('beta_label')

      expect_component('breadcrumbs') do |breadcrumb_data|
        breadcrumbs = breadcrumb_data['breadcrumbs']

        expect(breadcrumbs.count).to eq(3)
        expect(breadcrumbs).to include("title" => "Home", "url" => "/")
        expect(breadcrumbs).to include(
          "title" => "Education, training and skills",
          "url" => "/education"
        )
        expect(breadcrumbs.last['title']).to match(
          /buying for schools/i
        )
        expect(breadcrumbs.last['is_current_page']).to be_truthy
      end
    end
  end
end
