class Api::V1::BackgroundController < ApplicationController
  def index
    @background = Background.new(params[:location])

    render json: BackgroundSerializer.new(@background)
  end
end
