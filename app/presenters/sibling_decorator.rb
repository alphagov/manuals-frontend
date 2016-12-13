class SiblingDecorator < SimpleDelegator
  def initialize(document:, parent:)
    @parent = parent

    super(document)
  end

  def previous_sibling
    adjacent_siblings.first
  end

  def next_sibling
    adjacent_siblings.last
  end

private
  attr_reader :parent

  def current_section_id
    details.section_id
  end

  def siblings
    if parent
      parent.details.child_section_groups.map(&:child_sections).find { |section|
        section.map(&:section_id).include?(current_section_id)
      }
    end
  end

  def adjacent_siblings
    if siblings
      before, after = siblings.split { |section|
        section.section_id == current_section_id
      }

      [
        before.last,
        after.first,
      ]
    else
      [
        nil,
        nil,
      ]
    end
  end

end
