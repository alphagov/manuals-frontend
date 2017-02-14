class SectionGroup
  delegate :title, to: :group

  def initialize(section_group)
    @group = section_group
  end

  def sections
    (group.child_sections || []).map do |section|
      Section.new(section)
    end
  end

private

  attr_reader :group
end
