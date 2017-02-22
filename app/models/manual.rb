class Manual
  attr_reader :content_store_manual
  delegate :title, to: :content_store_manual

  def initialize(content_store_manual)
    @content_store_manual = content_store_manual
  end

  def beta?
    # HMRC manuals are still in beta, others are not
    hmrc?
  end

  def full_title
    if hmrc?
      content_store_manual.title + ' - HMRC internal manual'
    else
      content_store_manual.title + ' - Guidance'
    end
  end

  def updated_at
    Date.parse(content_store_manual.public_updated_at) if content_store_manual.public_updated_at.present?
  end

  def first_published_at
    Date.parse(content_store_manual.first_published_at) if content_store_manual.first_published_at.present?
  end

  def organisations
    content_store_manual.links.organisations ||
      content_store_manual.details.organisations || []
  end

  def taxons
    content_store_manual.links.taxons
  end

  def hmrc?
    organisations.map(&:title).include?('HM Revenue & Customs')
  end

  def url
    content_store_manual.base_path
  end

  def change_notes
    ChangeNotes.new(content_store_manual.details.change_notes || [])
  end

  def section_groups
    raw_section_groups.map { |group| SectionGroup.new(group) }
  end

  def summary
    content_store_manual.description
  end

  def body
    content_store_manual.details.body.html_safe if content_store_manual.details.body.present?
  end

private

  def raw_section_groups
    content_store_manual.details.child_section_groups || []
  end
end
