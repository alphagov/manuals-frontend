class ManualsController < ApplicationController

  before_filter :set_manual

  def index; end

  def show
    document = ManualsRepository.new.fetch(params["manual_id"], params["section_id"])
    error_not_found unless document
    @document = DocumentPresenter.new(document, @manual)
  end

  private

  def error_not_found
    render status: :not_found, text: "404 error not found"
  end

  def set_manual
    manual = ManualsRepository.new.fetch(params["manual_id"])
    error_not_found unless manual
    @manual = ManualPresenter.new(manual)
  end
end
