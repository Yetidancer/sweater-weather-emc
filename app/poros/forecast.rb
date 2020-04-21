class Forecast
  attr_reader :id, :location_data, :current, :hourly, :daily
  def initialize(place)
    data = service_calls(place)
    @id = nil
    @location_data = get_location_data(data[:location])
    @current = current_weather(data[:weather])
    @hourly = hourly_weather(data[:weather])
    @daily = daily_weather(data[:weather])
  end

  def get_location_data(location_info)
    {
      latitude: location_info[:geometry][:location][:lat],
      longitude: location_info[:geometry][:location][:lng],
      city_name: location_info[:address_components][0][:long_name],
      state_name: location_info[:address_components][2][:short_name],
      country_name: location_info[:address_components][3][:long_name]
    }
  end

  def current_weather(weather_info)
    weather = weather_info[:current].slice(:temp, :feels_like, :humidity, :visibility, :uvi, :weather)
    converts = {
      sunrise: Time.at(weather_info[:current][:sunrise]).to_datetime.strftime("%l:%M %p"),
      sunset: Time.at(weather_info[:current][:sunset]).to_datetime.strftime("%l:%M %p"),
      high: weather_info[:daily].first[:temp][:max],
      low: weather_info[:daily].first[:temp][:min],
    }
    weather.reverse_merge!(converts)
  end

  def hourly_weather(weather_info)
    weather_info[:hourly].first(8).map { |data|
        {
          time: Time.at(data[:dt]).to_datetime.strftime("%l %p"),
          temp: data[:temp],
          weather: data[:weather].first
        }
     }
  end

  def daily_weather(weather_info)
    weather_info[:daily][1..5].map { |data|
      daily = data.slice(:weather, :rain, :snow, :temp)
      daily[:day] = Time.at(data[:dt]).to_datetime.strftime("%A")
      daily
     }
  end

  def service_calls(place)
    location = GeocodeService.new.get_coordinates(place)

    coordinates = location[:geometry][:location]
    
    {location: location, weather: WeatherService.new.get_weather(coordinates[:lat], coordinates[:lng])}
  end

end
