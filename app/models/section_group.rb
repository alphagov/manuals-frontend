class SectionGroup
  def initialize(section_group)
    @group = section_group
  end

  def title
    group["title"]
  end

  def sections
    group.fetch("child_sections", []).map do |section|
      Section.new(section)
    end
  end

private

  attr_reader :group
end
