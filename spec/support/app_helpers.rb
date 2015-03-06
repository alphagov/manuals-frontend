module AppHelpers
  def view_manual_change_notes
    click_on "see all updates"
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
    within('header .primary') do
      expect(page).to have_content("Updated #{date}")
    end
  end

  def expect_title_tag_to_be(title)
    expect(page).to have_title(title)
  end

  def expect_manual_title_to_be(manual_title)
    within('header h1') do
      expect(page).to have_content(manual_title)
    end
  end

  def expect_section_title_to_be(section_title)
    within('h1.section-title') do
      expect(page).to have_content(section_title)
    end
  end

  def expect_a_child_section_group_title_of(child_section_group_title)
    within('.subsection-collection') do
      expect(page).to have_content(child_section_group_title)
    end
  end

  def expect_page_to_be_affiliated_with_org(options)
    expect(page).to have_link(options[:title],
                              "https://www.gov.uk/government/organisations/#{options[:slug]}")
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
end

RSpec.configuration.include AppHelpers, type: :feature
