class Api::V1::AntipodeController < ApplicationController

  def index
    city = params[:location]

    response = Faraday.new(url:"https://maps.googleapis.com/maps/api/geocode/json?address=#{city}&key=#{ENV['GOOGLE_API_KEY']}").post

    location = JSON.parse(response.body, symbolize_names: true)

    coordinates = location[:results].first[:geometry][:location]

    city_name = location[:results].first[:address_components][0][:long_name]


    # response = Faraday.new(url:"http://amypode.herokuapp.com/api/v1/antipodes?lat=#{coordinates[:lat]}&long=#{coordinates[:lng]}", headers: {api_key: 'oscar_the_grouch'}).post

    response = Faraday.get('http://amypode.herokuapp.com/api/v1/antipodes') do |req|
      req.params['lat'] = "#{coordinates[:lat]}"
      req.params['long'] = "#{coordinates[:lng]}"
      req.headers['api_key'] = "#{ENV['AMY_API_KEY']}"
    end


    antipode_location = JSON.parse(response.body, symbolize_names: true)

    antipode_coordinates = antipode_location[:data][:attributes]
    antipode_latlng = "#{antipode_coordinates[:lat]},#{antipode_coordinates[:long]}"

    # response = Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?latlng=#{antipode_coordinates[:lat]},#{antipode_coordinates[:long]}&key=#{ENV['GOOGLE_API_KEY']}")

    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |req|
      req.params['latlng'] = "#{antipode_coordinates[:lat]},#{antipode_coordinates[:long]}"
      req.params['key'] = "#{ENV['GOOGLE_API_KEY']}"
    end

    antipode_info = JSON.parse(response.body, symbolize_names: true)
    antipode_name = antipode_info[:results][1][:address_components].first[:long_name]


    response = Faraday.new(url: "https://api.openweathermap.org/data/2.5/onecall?lat=#{antipode_coordinates[:lat]}&lon=#{antipode_coordinates[:long]}&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=imperial").post

    antipode_weather = JSON.parse(response.body, symbolize_names: true)

    antipode_summary = antipode_weather[:current][:weather].first[:description]
    antipode_temp = antipode_weather[:current][:temp]
    antipode_params = {location_name: antipode_name, search_location: city_name}
    @antipode = Antipode.create!(antipode_params)
    forecast_params = {summary: antipode_summary, current_temperature: antipode_temp, antipode_id: @antipode.id}
    forecast = Forecast.create(forecast_params)

    render json: AntipodeSerializer.new(@antipode)

  end

end
