class WeatherService

  def get_weather(lat, long)
    response = Faraday.new(url: "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{long}&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=imperial").post

    JSON.parse(response.body, symbolize_names: true)
  end

end
