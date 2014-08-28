class SectionPresenter
  delegate :title, :body, to: :section

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

  def summary
    section.description
  end

private
  attr_reader :section

end
