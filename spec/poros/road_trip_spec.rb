require 'rails_helper'

RSpec.describe RoadTrip do
  it "can create a RoadTrip" do
    data = {
      origin: 'denver,do',
      destination: 'los angeles,ca',
      arrival_forecast: 78,
      travel_time: 50400,
      travel_time_formatted: '14:00:00'
    }
    rt = RoadTrip.new(data)
    expect(rt.origin).to eq(data[:origin])
    expect(rt.destination).to eq(data[:destination])
    expect(rt.arrival_forecast).to eq(data[:arrival_forecast])
    expect(rt.travel_time).to eq(data[:travel_time])
    expect(rt.travel_time_formatted).to eq(data[:travel_time_formatted])
  end
end
