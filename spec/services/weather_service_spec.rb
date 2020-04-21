require 'rails_helper'

describe 'weather service' do
  it 'should be able to grab weather data from the openweathermap api' do
    lat = 39.736396
    long = -104.945871

    result = WeatherService.new.get_weather(lat, long)

    expect(result.class).to eq(Hash)
  end
end
