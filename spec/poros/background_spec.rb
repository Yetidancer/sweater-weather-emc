require 'rails_helper'

describe 'background poro' do
  it 'can return a background' do
    place = 'denver,co'

    background = Background.new(place)

    expect(background.url.class).to eq(String)
  end
end
