class MapsService

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

  def get_directions(origin, destination)
    response = directions_call(origin, destination)

    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def coordinates_call(city)
    Faraday.new(url:"https://maps.googleapis.com/maps/api/geocode/json?address=#{city}&key=#{ENV['GOOGLE_API_KEY']}").post
  end

  def directions_call(origin, destination)
    response = conn.get("/maps/api/directions/json?key=#{ENV['GOOGLE_API_KEY']}&origin=#{origin}&destination=#{destination}")
  end

  def address_call(lat, long)
    response = conn.get('/maps/api/geocode/json') do |req|
      req.params['latlng'] = "#{lat},#{long}"
      req.params['key'] = "#{ENV['GOOGLE_API_KEY']}"
    end
  end

  def conn
    conn = Faraday.new(url: 'https://maps.googleapis.com')
  end
end
