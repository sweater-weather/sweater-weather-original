require 'rails_helper'

RSpec.describe 'Location Service' do
  it "can retrieve location data", :vcr do
    VCR.use_cassette('/Location_Service/can_retrieve_location_data') do
      keys = [ :street, :adminArea6, :adminArea6Type, :adminArea5, :adminArea5Type, :adminArea4, :adminArea4Type, :adminArea3, :adminArea3Type, :adminArea1, :adminArea1Type, :postalCode, :geocodeQualityCode, :geocodeQuality, :dragPoint, :sideOfStreet, :linkId, :unknownInput, :type, :latLng]
      location_data = LocationService.new.data('Washington,DC')
      keys.each do |key|
        expect(location_data[:results][0][:locations][0]).to have_key(key)
      end
      expect(location_data[:results][0][:locations][0][:latLng]).to have_key(:lat)
      expect(location_data[:results][0][:locations][0][:latLng]).to have_key(:lng)
    end
  end
end
