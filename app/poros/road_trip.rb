class RoadTrip
  attr_reader :id, :origin, :destination, :travel_time, :arrival_forecast
  def initialize(origin, destination)
    directions = service_calls(origin, destination)
    @id = nil
    @origin = origin
    @destination = destination
    @travel_time = find_travel_time(directions)
    @arrival_forecast = destination_weather
  end

  def find_travel_time(directions)
    travel_time_hours = directions[:routes].first[:legs].first[:duration][:value].to_f / 3600
  end

  def destination_weather
    hourly_weather_position = @travel_time.round
    hourly_destination_forecast = Forecast.new(@destination).hourly
    hourly_destination_forecast[hourly_weather_position]
  end

  def service_calls(origin, destination)
    MapsService.new.get_directions(origin, destination)
  end

end
