class ManualsController < ApplicationController

  def index
    manual = ManualsRepository.new.fetch(params["manual_id"])

    error_not_found unless manual
    @manual = ManualPresenter.new(manual)
  end

  def show
    manual = ManualsRepository.new.fetch(params["manual_id"])
    document = ManualsRepository.new.fetch(params['manual_id'], params['section_id'])

    error_not_found unless manual && document
    @manual = ManualPresenter.new(manual)
    @document = DocumentPresenter.new(document, @manual)
  end

  private

  def error_not_found
    render status: :not_found, text: "404 error not found"
  end

end
