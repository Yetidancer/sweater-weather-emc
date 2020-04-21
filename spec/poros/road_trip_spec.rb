require 'rails_helper'

describe 'roadtrip poro' do
  it 'can return a roadtrip' do
    origin = 'denver,co'
    destination = 'pueblo,co'

    roadtrip = RoadTrip.new(origin, destination)

    expect(roadtrip.origin.class).to eq(String)
    expect(roadtrip.destination.class).to eq(String)
    expect(roadtrip.travel_time.class).to eq(Float || Integer)
    expect(roadtrip.arrival_forecast.count).to eq(3)
  end
end
