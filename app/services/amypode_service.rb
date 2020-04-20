class AmypodeService

  def get_antipode(lat, long)
    response = Faraday.get('http://amypode.herokuapp.com/api/v1/antipodes') do |req|
      req.params['lat'] = "#{lat}"
      req.params['long'] = "#{long}"
      req.headers['api_key'] = "#{ENV['AMY_API_KEY']}"
    end

    JSON.parse(response.body, symbolize_names: true)
  end

end
