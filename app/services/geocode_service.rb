class GeocodeService

  def get_antipode_coordinates(city)
    coordinates = get_coordinates(city)[:geometry][:location]
    AmypodeService.new.get_antipode(coordinates[:lat], coordinates[:lng])[:data][:attributes]
  end

  def get_address_name(lat, long)
    info = get_address(lat, long)
    info[:results][1][:address_components].first[:long_name]
  end

  def get_city_name(city)
    get_coordinates(city)[:address_components][0][:long_name]
  end

  def get_coordinates(city)
    response = coordinates_call(city)

    JSON.parse(response.body, symbolize_names: true)[:results].first
  end

  def get_address(lat, long)
    response = address_call(lat, long)

    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def coordinates_call(city)
    Faraday.new(url:"https://maps.googleapis.com/maps/api/geocode/json?address=#{city}&key=#{ENV['GOOGLE_API_KEY']}").post
  end

  def address_call(lat, long)
    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |req|
      req.params['latlng'] = "#{lat},#{long}"
      req.params['key'] = "#{ENV['GOOGLE_API_KEY']}"
    end
  end
end
