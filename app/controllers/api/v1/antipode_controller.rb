class Api::V1::AntipodeController < ApplicationController

  def index
    city = params[:location]

    location = GeocodeService.new.get_coordinates(city)

    coordinates = original_coordinates(location)



    #service candidate
    response = Faraday.get('http://amypode.herokuapp.com/api/v1/antipodes') do |req|
      req.params['lat'] = "#{coordinates[:lat]}"
      req.params['long'] = "#{coordinates[:lng]}"
      req.headers['api_key'] = "#{ENV['AMY_API_KEY']}"
    end

    antipode_location = JSON.parse(response.body, symbolize_names: true)

    antipode_lat = antipode_coordinates(antipode_location)[:lat]
    antipode_long = antipode_coordinates(antipode_location)[:long]

    require "pry"; binding.pry


    #service candidate
    antipode_info = GeocodeService.new.get_address(antipode_lat, antipode_long)



    #service candidate
    response = Faraday.new(url: "https://api.openweathermap.org/data/2.5/onecall?lat=#{antipode_lat}&lon=#{antipode_long}&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=imperial").post

    antipode_weather = JSON.parse(response.body, symbolize_names: true)



    antipode_params = antipode_params(location, antipode_info)
    @antipode = Antipode.create!(antipode_params)

    forecast_params = forecast_params(antipode_weather, @antipode)
    forecast = Forecast.create(forecast_params)

    require "pry"; binding.pry

    render json: AntipodeSerializer.new(@antipode)

  end

  def antipode_params(original_info, antipode_info)
    city_name = original_info[:results].first[:address_components][0][:long_name]
    antipode_name = antipode_info[:results][1][:address_components].first[:long_name]
    {location_name: antipode_name, search_location: city_name}
  end

  def forecast_params(antipode_weather, antipode)
    antipode_summary = antipode_weather[:current][:weather].first[:description]
    antipode_temp = antipode_weather[:current][:temp]
    antipode_id = antipode.id
    {summary: antipode_summary, current_temperature: antipode_temp, antipode_id: antipode_id}
  end

  def original_coordinates(info)
    info[:results].first[:geometry][:location]
  end

  def antipode_coordinates(info)
    info[:data][:attributes]
  end

end
