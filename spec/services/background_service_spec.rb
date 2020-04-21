require 'rails_helper'

describe 'background service' do
  it 'should be able to grab a picture from the unsplash api' do
    result = BackgroundService.new.picture_grab('new york')

    expect(result[:results].first[:urls][:raw].class).to eq(String)
  end
end
