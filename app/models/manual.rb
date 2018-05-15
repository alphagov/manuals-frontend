class Manual
  attr_reader :content_store_manual

  def initialize(content_store_manual)
    @content_store_manual = content_store_manual
  end

  def title
    content_store_manual['title']
  end

  def details
    content_store_manual['details']
  end

  def beta?
    # HMRC manuals are still in beta, others are not
    hmrc?
  end

  def full_title
    title = content_store_manual['title'] || ''
    title += ' - ' unless title.blank?

    if hmrc?
      title + 'HMRC internal manual'
    else
      title + 'Guidance'
    end
  end

  def updated_at
    if content_store_manual['public_updated_at'].present?
      Date.parse(content_store_manual['public_updated_at'])
    end
  end

  def first_published_at
    if content_store_manual['first_published_at'].present?
      Date.parse(content_store_manual['first_published_at'])
    end
  end

  def organisations
    content_store_manual.dig('links', 'organisations') ||
      details['organisations'] ||
      []
  end

  def taxons
    content_store_manual.dig('links', 'taxons')
  end

  def hmrc?
    organisations.map { |org| org['title'] }.include?('HM Revenue & Customs')
  end

  def url
    content_store_manual['base_path']
  end

  def change_notes
    ChangeNotes.new(details['change_notes'] || [])
  end

  def section_groups
    raw_section_groups.map { |group| SectionGroup.new(group) }
  end

  def summary
    content_store_manual['description']
  end

  def body
    if details['body'].present?
      details['body'].html_safe
    end
  end

private

  def raw_section_groups
    content_store_manual.dig('details', 'child_section_groups') || []
  end
end
