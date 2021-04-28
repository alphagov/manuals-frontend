class ManualsController < ApplicationController
  rescue_from GdsApi::HTTPForbidden, with: :error_403
  rescue_from GdsApi::HTTPNotFound, with: :error_404
  rescue_from GdsApi::HTTPGone, with: :error_410
  rescue_from ActionView::MissingTemplate, with: :error_406
  rescue_from ActionController::UnknownFormat, with: :error_406

  before_action :follow_redirect_if_document_redirected, only: :show

  def index
    set_expiry(content_store_manual)

    render :index,
           locals: {
             presented_manual: presented_manual,
             content_item: content_store_manual,
           }
  end

  def show
    set_expiry(document_from_repository)
    document = Document.new(document_from_repository, manual)
    presented_document = DocumentPresenter.new(document: document)

    render :show,
           locals: {
             presented_manual: presented_manual,
             presented_document: presented_document,
           }
  end

  def updates
    render :updates,
           locals: {
             presented_manual: presented_manual,
           }
  end

private

  def presented_manual
    @presented_manual ||= ManualPresenter.new(manual: manual, view_context: view_context)
  end

  def content_store_manual
    @content_store_manual ||= GdsApi.content_store.content_item(manual_base_path)
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
    @document_from_repository ||= DocumentRepository.new.fetch(document_base_path)
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

  def follow_redirect_if_document_redirected
    if document_from_repository["document_type"] == "redirect"
      destination, status_code = GdsApi::ContentStore.redirect_for_path(
        document_from_repository, request.path, request.query_string
      )
      redirect_to destination, status: status_code
    end
  end

  def error_403
    render plain: "Forbidden", status: :forbidden
  end

  def error_404
    render plain: "Not found", status: :not_found
  end

  def error_406
    render plain: "Not acceptable", status: :not_acceptable
  end

  def error_410
    render plain: "Gone", status: :gone
  end
end
