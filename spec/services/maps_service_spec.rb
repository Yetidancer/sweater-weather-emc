require 'rails_helper'

describe 'maps service' do
  it 'can get coordinates' do
    city = 'denver'

    coordinates = MapsService.new.get_coordinates(city)
    require "pry"; binding.pry
    expect(coordinates[:address_components].class).to eq(Array)
  end

  it 'can get directions' do
    origin = 'denver, co'
    destination = 'pueblo, co'

    directions = MapsService.new.get_directions(origin, destination)

    expect(directions[:routes].class).to eq(Array)
  end
end
