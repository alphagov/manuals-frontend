class SectionPresenter
  delegate :title, :body, :description, to: :section

  def initialize(section)
    @section = section
  end

  def section_id
    section['section_id']
  end

  def path
    section.base_path
  end

  def collapsible?
    self.body.present?
  end

private
  attr_reader :section

end
