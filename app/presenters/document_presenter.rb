class DocumentPresenter
  delegate :title, to: :document

  def initialize(document, manual)
    @document = document
    @manual = manual
  end

  def section_id
    document['details']['manual-section-id']
  end

  def breadcrumb
    section_id || title
  end

  def summary
    if document['details']['sections'].present?
      document['details']['body']
    elsif document['details']['summary'].present?
      document['details']['summary']
    end
  end

  def sections_as_blob
    unless document['details']['sections'].present?
      document['details']['body']
    end
  end

  def section_groups
    raw_section_groups.map { |group| SectionGroupPresenter.new(group) }
  end

  def breadcrumbs
    crumbs = []
    if document['details']['breadcrumbs'].present?
      crumbs = document['details']['breadcrumbs'][1..-2].map do | section_id |
        OpenStruct.new(link: "#{manual.url}/#{section_id}", label: section_id)
      end
    else
      []
    end
  end

  def url
    document['web_url']
  end

private
  attr_reader :document, :manual

  def raw_section_groups
    document.details.section_groups || []
  end

end
