require 'rails_helper'

describe 'background API' do

  it 'can return background picture for a city' do
    city = 'denver, co'

    get "/api/v1/background?location=#{city}"

    expect(response).to be_successful

    data = JSON.parse(response.body, symbolize_names: true)

    url = data[:data][:attributes][:url]

    expect(url.class).to eq(String)

  end

end
