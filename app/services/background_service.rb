class BackgroundService

  def get_background(location)
    
  end

  private

  def get_background(url)
    response = conn.get(url)
    json_response = JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    conn = Faraday.new(url: "https://api.unsplash.com")
  end
end
