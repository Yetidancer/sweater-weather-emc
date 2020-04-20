class Api::V1::ForecastController < ApplicationController

  def index
    city = params[:location]

    response = Faraday.new(url:"https://maps.googleapis.com/maps/api/geocode/json?address=#{city}&key=#{ENV['GOOGLE_API_KEY']}").post

    location = JSON.parse(response.body, symbolize_names: true)

    coordinates = location[:results].first[:geometry][:location]

    city_name = location[:results].first[:address_components][0][:long_name]
    state_name = location[:results].first[:address_components][2][:short_name]
    country_name = location[:results].first[:address_components][3][:long_name]

    response_2 = Faraday.new(url: "https://api.openweathermap.org/data/2.5/onecall?lat=#{coordinates[:lat]}&lon=#{coordinates[:lng]}&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=imperial").post

    weather = JSON.parse(response_2.body, symbolize_names: true)

    current = weather[:current]

    location_data_params = {latitude: coordinates[:lat], longitude: coordinates[:lng], city: city_name, state: state_name, country: country_name}

    @location_data = LocationData.create!(location_data_params)



    # sunrise = DateTime.strptime(current[:sunrise].to_s,"%s")
    sunrise = Time.at(current[:sunrise]).to_datetime
    sunset = Time.at(current[:sunset]).to_datetime
    # sunset = DateTime.strptime(current[:sunset].to_s,"%s")

    current_params = {temp: current[:temp], high: weather[:daily].first[:temp][:max], low: weather[:daily].first[:temp][:min], description: current[:weather].first[:description], icon: current[:weather].first[:icon], feels_like: current[:feels_like], humidity: current[:humidity], visibility: current[:visibility], uv_index: current[:uvi], sunrise: sunrise.strftime("%l:%M %p"), sunset: sunset.strftime("%l:%M %p"), location_data_id: @location_data.id}

    current = Current.create(current_params)

    @location_data.update_attribute(:current_id, current.id)

    weather[:hourly].first(8).map { |data|
      # time = DateTime.strptime(data[:dt].to_s,'%s')
      time = Time.at(data[:dt]).to_datetime
      @location_data.hourlies.create!(time: time.strftime("%l %p"), temp: data[:temp], icon: data[:weather].first[:icon])
     }

    weather[:daily].first(6).map { |data|
      # time = DateTime.strptime(data[:dt].to_s,'%s')
      time = Time.at(data[:dt]).to_datetime
       @location_data.dailies.create(day: time.strftime("%A"), icon: data[:weather].first[:icon], description: data[:weather].first[:description], precipitation: data[:rain], high: data[:temp][:max], low: data[:temp][:min])
     }

     render json: LocationDataSerializer.new(@location_data)

  end


end
