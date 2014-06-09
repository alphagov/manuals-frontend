module ApplicationHelper

  def govspeak_to_html(markdown)
    doc = Govspeak::Document.new markdown
    return content_tag(:div, doc.to_html.html_safe, class: 'govspeak')
  end

  def links_to_sentence(links)
    links.map { |o|
      link_to(o.title, o.web_url)
    }.to_sentence
  end

  def marked_up_date(date, format = :long)
    content_tag(:time, localize(date, format: format), datetime: date.iso8601)
  end

end
