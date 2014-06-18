class ManualPresenter
  delegate :title, to: :manual

  def initialize(manual)
    @manual = manual
  end

  def updated_at
    Date.parse(manual.updated_at)
  end

  def organisations
    tags.select { |t| t.details.type == 'organisation' }
  end

  def hmrc?
    organisations.map(&:slug).include?('hm-revenue-customs')
  end

  def url
    manual.web_url
  end

  def updates_url
    "#{url}/updates"
  end

  def section_groups
    raw_section_groups.map { |group| SectionGroupPresenter.new(group) }
  end

  def body
    manual.details.summary
  end

private
  attr_reader :manual

  def raw_section_groups
    manual.details.section_groups || []
  end

  def tags
    manual.tags || []
  end
end
