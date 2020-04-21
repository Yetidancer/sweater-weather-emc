class Api::V1::ForecastController < ApplicationController

  def index
    location = GeocodeService.new.get_coordinates(params[:location])

    coordinates = location[:geometry][:location]

    weather = WeatherService.new.get_weather(coordinates[:lat], coordinates[:lng])

    @forecast = Forecast.new(location, weather)

    render json: ForecastSerializer.new(@forecast)
  end
end
