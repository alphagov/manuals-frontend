class Manual
  delegate :title, to: :manual

  def initialize(manual)
    @manual = manual
  end

  def beta?
    # HMRC manuals are still in beta, others are not
    hmrc?
  end

  def full_title
    if hmrc?
      @manual.title + ' - HMRC internal manual'
    else
      @manual.title + ' - Guidance'
    end
  end

  def updated_at
    Date.parse(manual.public_updated_at) if manual.public_updated_at.present?
  end

  def first_published_at
    Date.parse(manual.first_published_at) if manual.first_published_at.present?
  end

  def organisations
    @manual.links.organisations || @manual.details.organisations || []
  end

  def hmrc?
    organisations.map(&:title).include?('HM Revenue & Customs')
  end

  def url
    manual.base_path
  end

  def updates_url
    "#{url}/updates"
  end

  def change_notes
    ChangeNotes.new(manual.details.change_notes || [])
  end

  def section_groups
    raw_section_groups.map { |group| SectionGroup.new(group) }
  end

  def summary
    manual.description
  end

  def body
    manual.details.body.html_safe if manual.details.body.present?
  end

private

  attr_reader :manual

  def raw_section_groups
    manual.details.child_section_groups || []
  end
end
