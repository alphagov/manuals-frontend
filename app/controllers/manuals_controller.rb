require 'gds_api/helpers'

class ManualsController < ApplicationController
  include GdsApi::Helpers

  before_filter :set_manual

  def index; end

  def show
    document = fetch(params["manual_id"], params["section_id"])
    error_not_found unless document
    @document = DocumentPresenter.new(document, @manual)
  end

  def updates
  end

private

  def error_not_found
    render status: :not_found, text: "404 error not found"
  end

  def set_manual
    manual = fetch(params["manual_id"])
    unless manual
      if params["manual_id"] == 'employment-income-manual'
        render :employment_income_manual
      else
        error_not_found
      end
    end
    @manual = ManualPresenter.new(manual)
  end

  def fetch(manual_id, section_id = nil)
    path = '/' + [params[:prefix], manual_id, section_id].compact.join('/')
    content_store.content_item(path)
  end
end
