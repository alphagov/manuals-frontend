require 'gds_api/helpers'

class ManualsController < ApplicationController
  include GdsApi::Helpers

  def index
    @manual = ManualPresenter.new(manual)
  end

  def show
    document = fetch(params["manual_id"], params["section_id"])
    error_not_found unless document

    @manual = ManualPresenter.new(manual)
    @document = DocumentPresenter.new(document, @manual)
  end

  def updates
    @manual = ManualPresenter.new(manual)
  end

private

  def error_not_found
    render status: :not_found, text: "404 error not found"
  end

  def manual
    manual = fetch(params["manual_id"])
    unless manual
      if params["manual_id"] == 'employment-income-manual'
        render :employment_income_manual
      else
        error_not_found
      end
    end
    manual
  end

  def fetch(manual_id, section_id = nil)
    path = '/' + [params[:prefix], manual_id, section_id].compact.join('/')
    content_store.content_item(path)
  end
end
