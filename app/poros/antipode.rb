class Antipode
  attr_reader :id, :location_name, :search_location, :forecast
  def initialize(city_name)
    @id = nil
    @location_name = antipode(city_name)
    @search_location = city(city_name)
    @forecast = get_antipode_forecast(city_name)
  end

  private

  def antipode(city_name)
    coordinates = antipode_coordinates(city_name)
    GeocodeService.new.get_address_name(coordinates[:lat], coordinates[:long])
  end

  def antipode_coordinates(city_name)
    GeocodeService.new.get_antipode_coordinates(city_name)
  end

  def city(city_name)
    GeocodeService.new.get_city_name(city_name)
  end

  def get_antipode_forecast(city_name)
    coordinates = antipode_coordinates(city_name)

    weather = WeatherService.new.get_weather(coordinates[:lat], coordinates[:long])[:current]

    {summary: weather[:weather].first[:description], current_temperature: weather[:temp]}
  end
end
