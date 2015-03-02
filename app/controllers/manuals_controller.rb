require 'gds_api/helpers'

class ManualsController < ApplicationController
  include GdsApi::Helpers

  before_action :render_employment_income_manual
  before_action :ensure_manual_is_found
  before_action :ensure_document_is_found, only: :show

  def index
    @manual = ManualPresenter.new(manual)
  end

  def show
    @manual = ManualPresenter.new(manual)
    @document = DocumentPresenter.new(document, @manual)
    @siblings = SiblingPresenter.new(@document.section_id, parent)
  end

  def updates
    @manual = ManualPresenter.new(manual)
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
    fetch(manual_id)
  end

  def document
    fetch(manual_id, document_id)
  end

  def manual_id
    params["manual_id"]
  end

  def document_id
    params["section_id"]
  end

  def fetch(manual_id, section_id = nil)
    path = '/' + [params[:prefix], manual_id, section_id].compact.join('/')
    content_store.content_item(path)
  end

  def parent
    if @document.section_id 
      if @document.breadcrumbs.empty?
        return manual
      else
        return content_store.content_item(@document.breadcrumbs.last.link)
      end
    end
  end

end
