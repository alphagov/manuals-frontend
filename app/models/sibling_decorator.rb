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
    self['details']['section_id']
  end

  def siblings
    if parent
      child_section_groups = Array(parent.dig('details', 'child_section_groups'))
      child_section_groups.map { |groups| groups['child_sections'] }.find do |section|
        section.map { |section_payload| section_payload['section_id'] }.include?(current_section_id)
      end
    end
  end

  def adjacent_siblings
    if siblings
      before, after = siblings.split do |section|
        section['section_id'] == current_section_id
      end

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
