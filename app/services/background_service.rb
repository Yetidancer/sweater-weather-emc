class BackgroundService

  def picture_grab(location)
    get_background("search/photos?query=#{location}&client_id=#{ENV['SPLASH_API_KEY']}&per_page=1")
  end

  private

  def get_background(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    conn = Faraday.new(url: "https://api.unsplash.com")
  end
end
