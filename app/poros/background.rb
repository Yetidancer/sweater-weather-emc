class Background
  attr_reader :id, :url
  def initialize(place)
    @id = nil
    @url = find_picture(place)
  end

  def find_picture(place)
    data = BackgroundService.new.picture_grab(place)
    data[:results].first[:urls][:raw]
  end
end
