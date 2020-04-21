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


    expect(response).to be_successful
    roadtrip = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(roadtrip[:type]).to eq("road_trip")
    expect(roadtrip[:attributes][:origin]).to eq(roadtrip_params[:origin])
    expect(roadtrip[:attributes][:travel_time].class).to eq(Float)
    expect(roadtrip[:attributes][:arrival_forecast].count).to eq(3)
  end

  it 'cant get road_trip information if api_key incorrect' do
    user_params = {email: "cheese@gecko.net", password: "gruyere", password_confirmation: "gruyere"}

    post "/api/v1/users", params: user_params

    user_params = {email: "cheese@gecko.net", password: "gruyere"}

    post "/api/v1/sessions", params: user_params

    user = User.last

    roadtrip_params = {origin: "Denver,CO", destination: "Pueblo,CO", api_key: "NOTAUSERAPIKEY"}
    post "/api/v1/road_trip", params: roadtrip_params

    expect(response.status).to eq(401)

    bad_request = JSON.parse(response.body, symbolize_names: true)

    expect(bad_request[:error]).to eq("Wrong API Key!!! You hate to see it.")
  end

  it 'cant get road_trip information if bad route' do
    user_params = {email: "cheese@gecko.net", password: "gruyere", password_confirmation: "gruyere"}

    post "/api/v1/users", params: user_params

    user_params = {email: "cheese@gecko.net", password: "gruyere"}

    post "/api/v1/sessions", params: user_params

    user = User.last

    roadtrip_params = {origin: "Denver,CO", destination: "Melbourne", api_key: user.api_key}
    post "/api/v1/road_trip", params: roadtrip_params

    expect(response.status).to eq(401)

    bad_request = JSON.parse(response.body, symbolize_names: true)

    expect(bad_request[:error]).to eq("No route between origin and destination!!! You hate to see it.")
  end
end
