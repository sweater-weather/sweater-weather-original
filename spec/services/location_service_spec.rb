require 'rails_helper'

RSpec.describe 'Location Service' do
  it "can retrieve location data" do
    location = LocationService.new.data('Washington,DC')
    expect(location[:results][0][:locations][0][:latLng]).to have_key(:lat)
    expect(location[:results][0][:locations][0][:latLng]).to have_key(:lng)
  end
end
