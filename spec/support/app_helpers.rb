require 'slimmer/test_helpers/shared_templates'

module AppHelpers
  include Slimmer::TestHelpers::SharedTemplates

  def view_manual_change_notes
    updates_path = "#{current_path}/updates"
    expect_component("metadata", in_scope: 'header') do |metadata|
      expect(metadata).to have_key("other")
      expect(metadata["other"]).to have_key("Updated")
      updated_metadata = metadata.fetch("other").fetch("Updated")
      expect(updated_metadata).to have_link("see all updates", href: updates_path)
    end
    visit updates_path
  end

  def visit_manual(manual_slug)
    visit "/guidance/#{manual_slug}"
  end

  def visit_manual_section(manual_slug, section_slug)
    visit "/guidance/#{manual_slug}/#{section_slug}"
  end

  def visit_hmrc_manual(manual_slug)
    visit "/hmrc-internal-manuals/#{manual_slug}"
  end

  def visit_hmrc_manual_section(manual_slug, section_slug)
    visit "/hmrc-internal-manuals/#{manual_slug}/#{section_slug}"
  end

  def select_section(section_title)
    click_on section_title
  end

  def view_change_notes_for(label)
    page.find(".js-subsection-title", text: label).click
  end

  def expect_page_to_include_section(section_title, options = {})
    within('.subsection-collection') do
      if options[:href]
        expect(page).to have_link(section_title, href: options[:href])
      else
        expect(page).to have_content(section_title)
      end
      if options[:includes_text]
        within(:xpath, "//div[./h2[contains(.,'#{section_title}')]]") do
          expect(page).to have_content(options[:includes_text])
        end
      end
    end
  end

  def expect_manual_update_date_to_be(date)
    expect_component("metadata", in_scope: 'header') do |metadata|
      expect(metadata).to have_key("other")
      expect(metadata["other"]).to have_key("Updated")
      updated_metadata = metadata.fetch("other").fetch("Updated")
      expect(updated_metadata).to have_selector('time', text: date)
    end
  end

  def expect_title_tag_to_be(title)
    expect(page).to have_title(title)
  end

  def expect_manual_title_to_be(manual_title)
    raise ArgumentError, "You probably didn't mean to check for a blank manual title" if manual_title.blank?
    within('header h1') do
      expect(page).to have_content(manual_title)
    end
  end

  def expect_section_title_to_be(section_title)
    raise ArgumentError, "You probably didn't mean to check for a blank section title" if section_title.blank?
    within('h1.section-title') do
      expect(page).to have_content(section_title)
    end
  end

  def expect_a_child_section_group_title_of(child_section_group_title)
    raise ArgumentError, "You probably didn't mean to check for a blank child section group title" if child_section_group_title.blank?
    within('.subsection-collection') do
      expect(page).to have_content(child_section_group_title)
    end
  end

  def expect_page_to_be_affiliated_with_org(options)
    expect_component("metadata", in_scope: "header") do |metadata|
      expect(metadata).to have_key("from")
      expect(metadata["from"].length).to eq(1)
      expect(metadata["from"].first).to have_link(options[:title], href: "https://www.gov.uk/government/organisations/#{options[:slug]}")
    end
  end

  def expect_change_note(change_note, options)
    within(".subsection-collection") do
      expect(page).to have_link(options[:section_title], href: options[:section_href])
      expect(page).to have_content(change_note)
    end
  end

  def expect_page_to_contain_navigation_link(title, url)
    expect(page).to have_content(title)
    expect(page).to have_content(url)
  end

  def expect_component(component_type, in_scope: nil)
    component_selector = shared_component_selector(component_type)
    component_selector = "#{in_scope} #{component_selector}" if in_scope.present?
    if block_given?
      within(component_selector) do
        component_details = JSON.parse(page.text)
        yield component_details
      end
    else
      expect(page).to have_selector(component_selector)
    end
  end

  def expect_no_component(component_type)
    expect(page).not_to have_selector(shared_component_selector(component_type))
  end
end

RSpec.configuration.include AppHelpers, type: :feature
