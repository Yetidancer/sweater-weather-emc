class Forecast

  def initialize(location_info, weather_info)
    @location_data = location_data(location_info)
    @current = current(weather_info)
    @hourly = hourly(weather_info)
    @daily = daily(weather_info)
  end

  def location_data(location_info)
    {
      latitude: location_info[:results].first[:geometry][:location][:lat],
      longitude: location_info[:results].first[:geometry][:location][:long],
      city_name: location_info[:results].first[:address_components][0][:long_name],
      state_name: location_info[:results].first[:address_components][2][:short_name],
      country_name: location_info[:results].first[:address_components][3][:long_name]
    }
  end

  def current(weather_info)
    {
      temp: weather_info[:current][:temp],
      high: weather_info[:daily].first[:temp][:max],
      low: weather_info[:daily].first[:temp][:min],
      description: weather_info[:current][:weather].first[:description],
      icon: weather_info[:current][:weather].first[:icon],
      feels_like: weather_info[:current][:feels_like],
      humidity: weather_info[:current][:humidity],
      visibility: weather_info[:current][:visibility],
      uv_index: weather_info[:current][:uvi],
      sunrise: Time.at(weather_info[:current][:sunrise]).to_datetime.strftime("%l:%M %p"),
      sunset: Time.at(weather_info[:current][:sunset]).to_datetime.strftime("%l:%M %p")
    }
  end

  def hourly(weather_info)
    weather_info[:hourly].first(8).map { |data|
        {
          time: Time.at(data[:dt]).to_datetime.strftime("%l %p"),
          temp: data[:temp],
          icon: data[:weather].first[:icon]
        }
     }
  end

  def daily(weather_info)
    weather_info[:daily].first(6).map { |data|
         {
           day: Time.at(data[:dt]).to_datetime.strftime("%A"),
           icon: data[:weather].first[:icon],
           description: data[:weather].first[:description],
           precipitation: data[:rain],
           high: data[:temp][:max],
           low: data[:temp][:min]
         }
     }
  end
end
