class Document
  attr_reader :document, :manual
  delegate :previous_sibling, :next_sibling, to: :document

  def initialize(document, manual)
    @document = document
    @manual = manual
  end

  def title
    document['title']
  end

  def taxons
    manual['taxons']
  end

  def details
    document['details']
  end

  def section_id
    details['section_id']
  end

  def breadcrumb
    section_id || title
  end

  def full_title
    breadcrumb + ' - ' + @manual.full_title
  end

  def summary
    document['description']
  end

  def body
    details['body'] && details['body'].html_safe # rubocop:disable Rails/OutputSafety
  end

  def section_groups
    raw_section_groups.map { |group| SectionGroup.new(group) }
  end

  def breadcrumbs
    if details['breadcrumbs'].present?
      details['breadcrumbs'].map do |breadcrumb|
        Breadcrumb.new(link: breadcrumb['base_path'], label: breadcrumb['section_id'])
      end
    else
      []
    end
  end

  class Breadcrumb
    attr_reader :link, :label
    def initialize(link:, label:)
      @link = link
      @label = label
    end
  end

  def url
    document['base_path']
  end

  def collapse_depth
    # Stub method for when the API is giving us the document headings
    # We will always collapse the lowest given heading.
    # If only one level of headings are given, this returns 1. 2 is returned for 2, etc.
    # Only ever expecting this to return 1 or 2, but the code that uses this method will work for higher integers too.
    1
  end

private

  def raw_section_groups
    details['child_section_groups'] || []
  end
end
