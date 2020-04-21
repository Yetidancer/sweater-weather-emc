require 'rails_helper'

describe 'user API' do
  it 'can login a user' do
    user_params = {email: "cheese@gecko.net", password: "gruyere", password_confirmation: "gruyere"}

    post "/api/v1/users", params: user_params

    user_params = {email: "cheese@gecko.net", password: "gruyere"}

    post "/api/v1/sessions", params: user_params

    expect(response).to be_successful
    expect(response.status).to eq(200)

    session = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(session[:attributes][:api_key]).to eq(User.last.api_key)
  end

  it 'rejects user with wrong login info' do
    user_params = {email: "cheese@gecko.net", password: "gruyere", password_confirmation: "gruyere"}

    post "/api/v1/users", params: user_params

    user_params = {email: "cheese@gecko.net", password: "gouda"}

    post "/api/v1/sessions", params: user_params

    session = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(session[:error]).to eq('Incorrect email or password')
  end
end
