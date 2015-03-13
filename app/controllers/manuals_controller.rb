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
  end

  def updates
    @manual = ManualPresenter.new(manual)
  end

private

  def render_employment_income_manual
    if manual.nil? && params["manual_id"] == "employment-income-manual"
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
    fetch(params["manual_id"])
  end

  def document
    fetch(params["manual_id"], params["section_id"])
  end

  def fetch(manual_id, section_id = nil)
    path = '/' + [params[:prefix], manual_id, section_id].compact.join('/')
    content_store.content_item(path)
  end
end
