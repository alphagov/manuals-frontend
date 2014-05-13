class ManualsController < ApplicationController

  def index
    path = "public/EIM/EIMANUAL.json"
    @document = DocumentPresenter.new(JSON.parse(File.open(path).read))
    render :show
  end

  def show
    if params["section_id"].present?
      path = "public/EIM/#{params["section_id"]}.json"
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
