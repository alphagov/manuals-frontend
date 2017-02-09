module ApplicationHelper
  def links_to_sentence(links)
    links.map { |o|
      link_to(o.title, o.web_url)
    }.to_sentence
  end

  def marked_up_date(date, format = :long)
    content_tag(:time, localize(date, format: format), datetime: date.iso8601) if date.present?
  end

  def previous_and_next_links(document)
    siblings = {}

    if document.previous_sibling
      siblings[:previous_page] = {
        title: "Previous page",
        url: document.previous_sibling.base_path
      }
    end

    if document.next_sibling
      siblings[:next_page] = {
        title: "Next page",
        url: document.next_sibling.base_path
      }
    end

    siblings
  end
end
