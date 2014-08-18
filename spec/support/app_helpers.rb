module AppHelpers
  def view_manual_change_notes
    click_on "See all updates"
  end

  def visit_manual(manual_slug)
    visit "/guidance/#{manual_slug}"
  end

  def select_section(section_title)
    click_on section_title
  end
end

RSpec.configuration.include AppHelpers, type: :feature
