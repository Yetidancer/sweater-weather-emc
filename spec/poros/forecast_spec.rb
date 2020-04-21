require 'rails_helper'

describe 'forecast poro' do
  it 'can return a forecast' do
    place = 'denver,co'

    forecast = Forecast.new(place)

    expect(forecast.location_data.count).to eq(3)
    expect(forecast.current.count).to eq(10)
    expect(forecast.hourly.count).to eq(8)
    expect(forecast.daily.count).to eq(5)
  end
end
