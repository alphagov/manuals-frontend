class ManualsController < ApplicationController

  def index
    path = "public/#{params["manual_id"]}/index.json"
    @document = DocumentPresenter.new(JSON.parse(File.open(path).read))
    render :show
  end

  def show
    if params["section_id"].present?
      path = "public/#{params["manual_id"]}/#{params["section_id"]}.json"
      if File.exists?(path)
        @document = DocumentPresenter.new(JSON.parse(File.open(path).read))
      else
        render text: 'Not found', status: 404
      end
    else
      render text: 'Not found', status: 404
    end
  end

end
