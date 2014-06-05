class SectionPresenter
  delegate :title, :body, :summary, to: :section

  def initialize(section)
    @section = section
  end

  def section_id
    section['manual-section-id']
  end

private
  attr_reader :section

end
