require 'rails_helper'
require 'spec_helper'

describe 'user API' do

  it 'can create user with unique api key' do
    user_params = {email: "cheese@gecko.net", password: "gruyere", password_confirmation: "gruyere"}

    post "/api/v1/users", params: user_params
    # require "pry"; binding.pry

    user = User.last

    # require "pry"; binding.pry
    expect(response).to be_successful

    expect(response.status).to eq(201)
    user = JSON.parse(response.body, symbolize_names: true)


    user_attributes = user[:data][:attributes]

    expect(user_attributes[:email].class).to eq(String)
    expect(user_attributes[:api_key].class).to eq(String)
  end

  it 'can return error if passwords do not match' do
    user_params = {email: "cheese@gecko.net", password: "gruyere", password_confirmation: "gouda"}

    post "/api/v1/users", params: user_params

    # expect(response).to be_successful

    expect(response.status).to eq(400)

    error = JSON.parse(response.body, symbolize_names: true)

    # require "pry"; binding.pry

    expect(error.keys.first).to eq(:password_confirmation)
  end
end
