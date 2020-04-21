require 'rails_helper'

describe 'WeatherForecast API' do

  it 'can return weather forecast for a city' do
    city = 'denver, co'

    get "/api/v1/forecast?location=#{city}"

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)

    current = data[:data][:attributes][:current]
    hourly = data[:data][:attributes][:hourly]
    daily = data[:data][:attributes][:daily]

    # require "pry"; binding.pry

    expect(hourly.count).to eq(8)
    expect(daily.count).to eq(5)
    expect(current[:temp].class).to eq(Float || Integer)
    expect(data[:data][:type]).to eq("forecast")
  end

end
