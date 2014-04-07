class ManualsController < ApplicationController

  def show
    render text: 'Not found', status: 404 unless params[:id] == 'magic-slug'
  end

end
