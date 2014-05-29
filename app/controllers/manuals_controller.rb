class ManualsController < ApplicationController

  def index
    path = "public/#{params["manual_id"]}/index.json"
    file = OpenStruct.new(JSON.parse(File.open(path).read))
    @manual = ManualPresenter.new(params["manual_id"], file)
    @document = DocumentPresenter.new(file)
    render :show
  end

  def show
    if params["section_id"].present?
      path = "public/#{params["manual_id"]}/#{params["section_id"]}.json"
      if File.exists?(path)
        @manual = ManualPresenter.new(params["manual_id"], file)
        @document = DocumentPresenter.new(JSON.parse(File.open(path).read))
      else
        render text: 'Not found', status: 404
      end
    else
      render text: 'Not found', status: 404
    end
  end

end
