require 'rails_helper'

RSpec.describe 'Climbing routes service' do
  it "can get climbing routes details" do
    lat=40.03
    lon=-105.25
    keys = [:id, :name, :type, :rating, :stars, :starVotes, :pitches, :location, :url, :imgSqSmall, :imgSmall, :imgSmallMed, :imgMedium, :longitude, :latitude]
    service = ClimbingRoutesService.new.routes(lat, lon)
    keys.each do |key|
      expect(service).to have_key(key)
    end
  end
end
