class Api::V1::AntipodeController < ApplicationController
  def index
    city = params[:location]

    @antipode = AntipodeFacade.new.make_antipode(city)

    require "pry"; binding.pry

    render json: AntipodeSerializer.new(@antipode)
  end
end
