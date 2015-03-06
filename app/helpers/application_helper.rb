module ApplicationHelper

  def links_to_sentence(links)
    links.map { |o|
      link_to(o.title, o.web_url)
    }.to_sentence
  end

  def marked_up_date(date, format = :long)
    content_tag(:time, localize(date, format: format), datetime: date.iso8601)
  end

  def previous_and_next_links(document)
    siblings = {}

    if document.siblings.previous
      siblings.merge!( 
        previous_page: {
          "title" => "Previous page",
          "url" => document.siblings.previous.base_path
        }
      )
    end
    if document.siblings.next
      siblings.merge!(
        next_page: {
          "title" => "Next page",
          "url" => document.siblings.next.base_path
        }
      )
    end
    siblings
  end

end
