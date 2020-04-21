class MapsService

  def get_antipode_coordinates(city)
    coordinates = get_coordinates(city)[:geometry][:location]
    AmypodeService.new.get_antipode(coordinates[:lat], coordinates[:lng])[:data][:attributes]
  end

  def get_address_name(lat, long)
    latlng = "#{lat},#{long}"

    address_info = get_json("/maps/api/geocode/json?key=#{ENV['GOOGLE_API_KEY']}&latlng=#{latlng}")

    address_info[:results][1][:address_components].first[:long_name]
  end

  def get_city_name(city)
    get_coordinates(city)[:address_components][0][:long_name]
  end

  def get_coordinates(city)
    get_json("/maps/api/geocode/json?address=#{city}&key=#{ENV['GOOGLE_API_KEY']}")[:results].first
  end

  def get_directions(origin, destination)
    get_json("/maps/api/directions/json?key=#{ENV['GOOGLE_API_KEY']}&origin=#{origin}&destination=#{destination}")
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    conn = Faraday.new(url: 'https://maps.googleapis.com')
  end
end
