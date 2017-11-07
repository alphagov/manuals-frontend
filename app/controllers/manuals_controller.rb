class ManualsController < ApplicationController
  include TasklistHeaderABTestable

  before_action :ensure_manual_is_found
  before_action :ensure_document_is_found, only: :show

  def index
    set_expiry(content_store_manual)

    render :index, locals: {
      presented_manual: presented_manual,
    }
  end

  def show
    set_expiry(document_from_repository)
    document = Document.new(document_from_repository, manual)
    presented_document = DocumentPresenter.new(document: document)

    render :show, locals: {
      presented_manual: presented_manual,
      presented_document: presented_document,
    }
  end

  def updates
    render :updates, locals: {
      presented_manual: presented_manual,
    }
  end

private

  def presented_manual
    @presented_manual ||=
      ManualPresenter.new(manual: manual, view_context: view_context)
  end

  def ensure_manual_is_found
    if content_store_manual.nil?
      error_not_found
    elsif content_store_manual["format"] == "gone"
      error_gone
    end
  end

  def ensure_document_is_found
    error_not_found unless document_from_repository.present?
  end

  def error_not_found
    render status: :not_found, text: "404 error not found"
  end

  def error_gone
    render status: :gone, text: "410 gone"
  end

  def content_store_manual
    @content_store_manual ||= begin
      Services.content_store.content_item(manual_base_path)
    rescue GdsApi::ContentStore::ItemNotFound
      nil
    end
  end

  def manual
    @manual = Manual.new(content_store_manual)
  end

  def manual_base_path
    "/#{params[:prefix]}/#{manual_id}"
  end

  def manual_id
    params["manual_id"]
  end

  def document_from_repository
    @document_from_repository ||=
      DocumentRepository.new.fetch(document_base_path)
  end

  def document_base_path
    "/#{params[:prefix]}/#{manual_id}/#{document_id}"
  end

  def document_id
    params["section_id"]
  end

  def set_expiry(content_item)
    max_age = content_item.cache_control.max_age
    cache_private = content_item.cache_control.private?
    expires_in(max_age, public: !cache_private)
  end
end
