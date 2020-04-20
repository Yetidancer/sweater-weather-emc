require 'rails_helper'

describe 'WeatherForecast API' do

  it 'can return weather forecast for a city' do
    city = 'denver, co'

    get "/api/v1/forecast?location=#{city}"

    expect(response).to be_successful

    require "pry"; binding.pry
  end

end
