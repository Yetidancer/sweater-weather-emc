class Antipode
  attr_reader :id, :location_name, :search_location, :forecast, :antipode_coordinates
  def initialize(city_name)
    @id = nil
    @antipode_coordinates = MapsService.new.get_antipode_coordinates(city_name)
    @location_name = antipode
    @search_location = city(city_name)
    @forecast = get_antipode_forecast
  end

  private

  def antipode
    coordinates = @antipode_coordinates
    MapsService.new.get_address_name(coordinates[:lat], coordinates[:long])
  end

  def city(city_name)
    MapsService.new.get_city_name(city_name)
  end

  def get_antipode_forecast
    coordinates = @antipode_coordinates

    weather = WeatherService.new.get_weather(coordinates[:lat], coordinates[:long])[:current]

    {summary: weather[:weather].first[:description], current_temperature: weather[:temp]}
  end
end
