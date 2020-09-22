require 'rails_helper'

RSpec.describe RoadTripFacade do
  it "can create a RoadTrip", :vcr do
    VCR.use_cassette('/RoadTripFacade/can_create_a_RoadTrip') do
      road_trip = RoadTripFacade.new('denver,co', 'san diego,ca').road_trip
      expect(road_trip).to be_an_instance_of(RoadTrip)
    end
  end
end
