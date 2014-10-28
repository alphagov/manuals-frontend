class DocumentPresenter
  delegate :title, to: :document

  def initialize(document, manual)
    @document = document
    @manual = manual
  end

  def section_id
    document['details']['section_id']
  end

  def breadcrumb
    section_id || title
  end

  def summary
    document['description']
  end

  def body
    document['details']['body'] && document['details']['body'].html_safe
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
    document['base_path']
  end

  def collapse_depth
    # Stub method for when the API is giving us the document headings
    # We will always collapse the lowest given heading.
    # If only one level of headings are given, this returns 1. 2 is returned for 2, etc.
    # Only ever expecting this to return 1 or 2, but the codde that uses this method will work for higher integers too.
    return 1
  end

private
  attr_reader :document, :manual

  def raw_section_groups
    document.details.child_section_groups || []
  end

end
