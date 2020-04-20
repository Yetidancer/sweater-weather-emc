class AntipodeFacade

  def make_antipode(city)
        location = GeocodeService.new.get_coordinates(city)

        coordinates = original_coordinates(location)
###
        # antipode_location = AmypodeService.new.get_antipode(coordinates[:lat], coordinates[:lng])
        #
        # antipode_lat = antipode_coordinates(antipode_location)[:lat]
        # antipode_long = antipode_coordinates(antipode_location)[:long]
        #
        # antipode_info = GeocodeService.new.get_address(antipode_lat, antipode_long)
###
        antipode_info = antipode_info(coordinates[:lat], coordinates[:lng])

        #service candidate
        antipode_weather = WeatherService.new.get_weather(antipode_lat, antipode_long)




        antipode_params = antipode_params(location, antipode_info)
        antipode = Antipode.create!(antipode_params)

        forecast_params = forecast_params(antipode_weather, antipode)
        forecast = Forecast.create(forecast_params)

        antipode
  end

  private

  def antipode_params(original_info, antipode_info)
    city_name = original_info[:results].first[:address_components][0][:long_name]
    antipode_name = antipode_info[:results][1][:address_components].first[:long_name]
    {location_name: antipode_name, search_location: city_name}
  end

  def forecast_params(antipode_weather, antipode)
    antipode_summary = antipode_weather[:current][:weather].first[:description]
    antipode_temp = antipode_weather[:current][:temp]
    antipode_id = antipode.id
    {summary: antipode_summary, current_temperature: antipode_temp, antipode_id: antipode_id}
  end

  def original_coordinates(info)
    info[:results].first[:geometry][:location]
  end

  def antipode_coordinates(info)
    info[:data][:attributes]
  end

  def antipode_info(lat, long)
    antipode_location = AmypodeService.new.get_antipode(lat, long)

    antipode_lat = antipode_coordinates(antipode_location)[:lat]
    antipode_long = antipode_coordinates(antipode_location)[:long]

    GeocodeService.new.get_address(antipode_lat, antipode_long)
  end

end
