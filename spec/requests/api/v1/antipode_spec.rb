require 'rails_helper'

describe 'WeatherAntipode API' do
  it 'can return weather forecast for an antipode city' do
    city = 'hong kong'

    get "/api/v1/antipode?location=#{city}"

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:data].class).to eq(Hash)
    expect(data[:data][:attributes].count).to eq(3)
    expect(data[:data][:attributes][:forecast][:summary].class).to eq(String)
  end
end
