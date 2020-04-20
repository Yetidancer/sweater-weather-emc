require 'rails_helper'

describe 'WeatherForecast API' do

  it 'can return weather forecast for a city' do
    city = 'denver, co'

    get "/api/v1/forecast?location=#{city}"

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)

    current = data[:data][:attributes][:current]
    hourlies = data[:data][:attributes][:hourlies]
    dailies = data[:data][:attributes][:dailies]

    expect(hourlies.count).to eq(8)
    expect(dailies.count).to eq(6)
    expect(current[:temp].class).to eq(Integer)
    expect(data[:data][:type]).to eq("location_data")
  end

end
