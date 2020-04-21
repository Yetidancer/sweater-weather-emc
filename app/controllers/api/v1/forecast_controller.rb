class Api::V1::ForecastController < ApplicationController

  def index
    city = params[:location]

    ###get location coordinates, city, state, and country

    response = Faraday.new(url:"https://maps.googleapis.com/maps/api/geocode/json?address=#{city}&key=#{ENV['GOOGLE_API_KEY']}").post

    location = JSON.parse(response.body, symbolize_names: true)

    coordinates = location[:results].first[:geometry][:location]

    city_name = location[:results].first[:address_components][0][:long_name]
    state_name = location[:results].first[:address_components][2][:short_name]
    country_name = location[:results].first[:address_components][3][:long_name]

    ###get weather for those coordinates

    response_2 = Faraday.new(url: "https://api.openweathermap.org/data/2.5/onecall?lat=#{coordinates[:lat]}&lon=#{coordinates[:lng]}&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=imperial").post

    weather = JSON.parse(response_2.body, symbolize_names: true)

    current = weather[:current]

    location_data_params = {latitude: coordinates[:lat], longitude: coordinates[:lng], city: city_name, state: state_name, country: country_name}

    @location_data = LocationData.create!(location_data_params)

    current_params = {
      temp: weather[:current][:temp],
      high: weather[:daily].first[:temp][:max],
      low: weather[:daily].first[:temp][:min],
      description: weather[:current][:weather].first[:description],
      icon: weather[:current][:weather].first[:icon],
      feels_like: weather[:current][:feels_like],
      humidity: weather[:current][:humidity],
      visibility: weather[:current][:visibility],
      uv_index: weather[:current][:uvi],
      sunrise: Time.at(weather[:current][:sunrise]).to_datetime.strftime("%l:%M %p"),
      sunset: Time.at(weather[:current][:sunset]).to_datetime.strftime("%l:%M %p")
    }

    current = Current.create(current_params)

    @location_data.update_attribute(:current_id, current.id)

    weather[:hourly].first(8).map { |data|
      time = Time.at(data[:dt]).to_datetime
      @location_data.hourlies.create!(
        time: time.strftime("%l %p"),
        temp: data[:temp],
        icon: data[:weather].first[:icon]
      )
     }

    weather[:daily].first(6).map { |data|
      time = Time.at(data[:dt]).to_datetime
       @location_data.dailies.create(
         day: time.strftime("%A"),
         icon: data[:weather].first[:icon],
         description: data[:weather].first[:description],
         precipitation: data[:rain],
         high: data[:temp][:max],
         low: data[:temp][:min]
       )
     }

     render json: LocationDataSerializer.new(@location_data)

  end


end
