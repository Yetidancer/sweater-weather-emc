class WeatherService

  def get_weather(lat, long)
    get_json("/data/2.5/onecall?lat=#{lat}&lon=#{long}&appid=#{ENV['OPEN_WEATHER_API_KEY']}&units=imperial")
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    conn = Faraday.new(url: 'https://api.openweathermap.org')
  end
end
