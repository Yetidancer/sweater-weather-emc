require 'rails_helper'

describe 'antipode poro' do
  it 'can return a antipode' do
    place = 'hong kong'

    antipode = Antipode.new(place)

    expect(antipode.antipode_coordinates.count).to eq(2)

    expect(antipode.location_name.class).to eq(String)
    expect(antipode.search_location.class).to eq(String)
    expect(antipode.forecast.count).to eq(2)
  end

  it 'can return a antipode' do
    place = 'denver'

    antipode = Antipode.new(place)

    expect(antipode.location_name).to eq("No region name")
  end
end
