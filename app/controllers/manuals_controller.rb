class ManualsController < ApplicationController

  def show
    @document = JSON.parse(File.open('public/EIM11200.json').read)

    render text: 'Not found', status: 404 unless params[:id] == 'magic-slug'

  end

end
