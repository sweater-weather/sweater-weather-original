require 'rails_helper'

RSpec.describe RoadTripSerializer do
  it "can serialize a RoadTripFacade", :vcr do
    VCR.use_cassette('/RoadTripSerializer/can_serialize_a_RoadTripFacade') do
      rt = RoadTripFacade.new('denver,co', 'los angeles,ca').road_trip
      serialized = RoadTripSerializer.new(rt).serializable_hash

      expect(serialized).to have_key(:data)
      expect(serialized[:data]).to have_key(:id)
      expect(serialized[:data]).to have_key(:type)
      expect(serialized[:data]).to have_key(:attributes)
      keys = [:origin, :destination, :travel_time, :travel_time_formatted, :arrival_forecast]
      keys.each do |key|
        expect(serialized[:data][:attributes]).to have_key(key)
      end
    end
  end
end
