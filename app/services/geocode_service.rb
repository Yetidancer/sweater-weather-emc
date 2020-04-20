class GeocodeService

  def get_coordinates(city)
    response = Faraday.new(url:"https://maps.googleapis.com/maps/api/geocode/json?address=#{city}&key=#{ENV['GOOGLE_API_KEY']}").post

    JSON.parse(response.body, symbolize_names: true)
  end

  def get_address(lat, long)
    response = Faraday.get('https://maps.googleapis.com/maps/api/geocode/json') do |req|
      req.params['latlng'] = "#{lat},#{long}"
      req.params['key'] = "#{ENV['GOOGLE_API_KEY']}"
    end

    JSON.parse(response.body, symbolize_names: true)
  end

end
