class Document
  attr_reader :document, :manual

  delegate :previous_sibling, :next_sibling, to: :document

  def initialize(document, manual)
    @document = document
    @manual = manual
  end

  def title
    document["title"]
  end

  def taxons
    manual["taxons"]
  end

  def details
    document["details"]
  end

  def section_id
    details["section_id"]
  end

  def breadcrumb
    section_id || title
  end

  def full_title
    "#{breadcrumb} - #{@manual.full_title}"
  end

  def summary
    document["description"]
  end

  def body
    details["body"] && details["body"].html_safe
  end

  def visually_expanded?
    details.fetch("visually_expanded", false)
  end

  def intro
    return nil unless body

    intro = Nokogiri::HTML::DocumentFragment.parse(body)

    # Strip all content following and including the first heading level specified by collapse_path
    intro.css("h#{collapse_depth}").xpath("following-sibling::*").remove
    intro.css("h#{collapse_depth}").remove

    intro
  end

  def main
    return nil unless body

    document = Nokogiri::HTML::DocumentFragment.parse(body)

    # Identifies all headings of the level specified in collapse_path and creates an array of objects from the heading and its proceeding content up to the next heading
    # This is so that it can be consumed by accordion components in the template
    # See _manual_section.html.erb for how this is being rendered
    document.css("h#{collapse_depth}").map do |heading|
      content = []

      heading.xpath("following-sibling::*").each do |element|
        if element.name == "h2"
          break
        else
          content << element.to_html
        end
      end

      {
        heading: {
          text: heading.text,
          id: heading[:id],
        },
        content: content.join,
      }
    end
  end

  def section_groups
    raw_section_groups.map { |group| SectionGroup.new(group) }
  end

  def breadcrumbs
    if details["breadcrumbs"].present?
      details["breadcrumbs"].map do |breadcrumb|
        Breadcrumb.new(link: breadcrumb["base_path"], label: breadcrumb["section_id"])
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
    document["base_path"]
  end

  def collapse_depth
    # Stub method for when the API is giving us the document headings
    # We will always collapse the lowest given heading.
    # If only one level of headings are given, this returns 1. 2 is returned for 2, etc.
    # Only ever expecting this to return 1 or 2, but the code that uses this method will work for higher integers too.
    2
  end

private

  def raw_section_groups
    details["child_section_groups"] || []
  end
end
