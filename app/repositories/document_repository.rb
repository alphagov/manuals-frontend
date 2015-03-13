require "gds_api/content_store"

class DocumentRepository
  def fetch(base_path)
    document = fetch_content_item(base_path)
    parent = fetch_content_item(
      extract_parent_base_path_from_document(document)
    )

  end

private
  def fetch_content_item(base_path)
    content_store.content_item(base_path)
  end

  def content_store
    GdsApi::ContentStore.new(Plek.new.find("content-store"))
  end

  def extract_parent_base_path_from_document(document)
  end

  def workout_the_siblings
  end
end
