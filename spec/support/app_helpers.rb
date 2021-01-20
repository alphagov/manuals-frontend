module AppHelpers
  def view_manual_change_notes
    updates_path = "#{current_path}/updates"
    within ".gem-c-metadata" do
      expect(page).to have_link("see all updates", href: updates_path)
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
    page.find(".gem-c-accordion__section-button", text: label).click
  end

  def expect_page_to_include_section(section_title, options = {})
    within(".subsection-collection") do
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
    within ".gem-c-metadata" do
      expect(page).to have_selector("time", text: date)
    end
  end

  def expect_title_tag_to_be(title)
    expect(page).to have_title(title)
  end

  def expect_manual_title_to_be(manual_title)
    raise ArgumentError, "You probably didn't mean to check for a blank manual title" if manual_title.blank?

    within("header h1") do
      expect(page).to have_content(manual_title)
    end
  end

  def expect_section_title_to_be(section_title)
    raise ArgumentError, "You probably didn't mean to check for a blank section title" if section_title.blank?

    within("article h1") do
      expect(page).to have_content(section_title)
    end
  end

  def expect_a_child_section_group_title_of(child_section_group_title)
    raise ArgumentError, "You probably didn't mean to check for a blank child section group title" if child_section_group_title.blank?

    within(".subsection-collection") do
      expect(page).to have_content(child_section_group_title)
    end
  end

  def expect_page_to_be_affiliated_with_org(options)
    within ".gem-c-metadata" do
      expect(page).to have_link(options[:title], href: "https://www.gov.uk/government/organisations/#{options[:slug]}")
    end
  end

  def expect_change_note(change_note, options)
    expect(page).to have_link(options[:section_title], href: options[:section_href])
    expect(page).to have_content(change_note)
  end

  def expect_page_to_have_machine_readable_metadata(title)
    schema_sections = page.find_all("script[type='application/ld+json']", visible: false)
    schemas = schema_sections.map { |section| JSON.parse(section.text(:all)) }

    org_schema = schemas.detect { |schema| schema["@type"] == "Article" }
    expect(org_schema["name"]).to eq title

    tag = "link[rel='canonical']"
    expect(page).to have_css(tag, visible: false)
  end
end

RSpec.configuration.include AppHelpers, type: :feature
