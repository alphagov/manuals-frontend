class ManualsController < ApplicationController

  def index
    file = ManualsRepository.new.fetch(params["manual_id"])
    @manual = ManualPresenter.new(params["manual_id"], file)
    @document = DocumentPresenter.new(file)
    render :show
  end

  def show
    if params["section_id"].present?
      file = ManualsRepository.new.fetch(params["manual_id"], params["section_id"])
      if file
        @manual = ManualPresenter.new(params["manual_id"], file)
        @document = DocumentPresenter.new(file)
      else
        render text: 'Not found', status: 404
      end
    else
      render text: 'Not found', status: 404
    end
  end

end
