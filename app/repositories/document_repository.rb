require "gds_api/content_store"

class DocumentRepository
  def fetch(base_path)
    document = fetch_content_item(base_path)

    if document
      parent = fetch_parent_for_document(document)

      SiblingDecorator.new(
        document: document,
        parent: parent,
      )
    end
  end

private
  def fetch_content_item(base_path)
    content_store.content_item(base_path)
  end

  def content_store
    GdsApi::ContentStore.new(Plek.new.find("content-store"), disable_cache: true)
  end

  def extract_parent_base_path_from_document(document)
    if document.details.breadcrumbs.present?
      document.details.breadcrumbs.last.base_path
    else
      document.details.manual.base_path
    end
  end

  def fetch_parent_for_document(document)
    fetch_content_item(
      extract_parent_base_path_from_document(document)
    )
  end
end
