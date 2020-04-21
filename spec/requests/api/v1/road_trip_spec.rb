require 'rails_helper'

describe 'road_trip api' do

  it 'can get road_trip information' do
    user_params = {email: "cheese@gecko.net", password: "gruyere", password_confirmation: "gruyere"}

    post "/api/v1/users", params: user_params

    user_params = {email: "cheese@gecko.net", password: "gruyere"}

    post "/api/v1/sessions", params: user_params

    user = User.last

    roadtrip_params = {origin: "Denver,CO", destination: "Pueblo,CO", api_key: user.api_key}
    post "/api/v1/road_trip", params: roadtrip_params

    # require "pry"; binding.pry

    expect(response).to be_successful
    roadtrip = JSON.parse(response.body, symbolize_names: true)[:data]
  end
end
