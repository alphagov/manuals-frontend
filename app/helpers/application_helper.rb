module ApplicationHelper

  def govspeak_to_html(markdown)
    doc = Govspeak::Document.new markdown
    return doc.to_html.html_safe
  end

end
