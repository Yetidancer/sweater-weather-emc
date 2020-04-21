class Api::V1::AntipodeController < ApplicationController
  def index
    @antipode = Antipode.new(params[:location])

    render json: AntipodeSerializer.new(@antipode)
  end
end
