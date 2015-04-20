require 'gds_api/helpers'

class ManualsController < ApplicationController
  include GdsApi::Helpers

  before_action :render_employment_income_manual
  before_action :ensure_manual_is_found
  before_action :ensure_document_is_found, only: :show
  before_action :load_manual
  before_action :prevent_robots_from_indexing_hmrc_manuals

  def index
  end

  def show
    @document = DocumentPresenter.new(document, @manual)
  end

  def updates
  end

private

  def render_employment_income_manual
    if manual.nil? && manual_id == "employment-income-manual"
      render :employment_income_manual
    end
  end

  def ensure_manual_is_found
    error_not_found unless manual
  end

  def ensure_document_is_found
    error_not_found unless document
  end

  def error_not_found
    render status: :not_found, text: "404 error not found"
  end

  def manual
    content_store.content_item(manual_base_path)
  end

  def load_manual
    @manual = ManualPresenter.new(manual)
  end

  def manual_base_path
    "/#{params[:prefix]}/#{manual_id}"
  end

  def manual_id
    params["manual_id"]
  end

  def document
    document_repository.fetch(document_base_path)
  end

  def document_base_path
    "/#{params[:prefix]}/#{manual_id}/#{document_id}"
  end

  def document_id
    params["section_id"]
  end

  def document_repository
    DocumentRepository.new
  end

  def prevent_robots_from_indexing_hmrc_manuals
    if @manual.hmrc?
      response.headers["X-Robots-Tag"] = "none"
    end
  end
end
