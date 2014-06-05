class SectionGroupPresenter
  delegate :title, to: :group

  def initialize(section_group)
    @group = section_group
  end

  def sections
    group.sections.map do |section|
      SectionPresenter.new(section)
    end
  end

private
  attr_reader :group

end
