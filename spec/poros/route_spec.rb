require 'rails_helper'

RSpec.describe Route do
  it "can create a ClimbingRoute" do
    data = {
      name: "Dopey Duck",
      type: "Trad",
      rating: "5.9",
      location: [
        "North Carolina",
        "2. Northern Mountains Region",
        "Linville Gorge",
        "Shortoff Mountain"
      ],
    }
    r = Route.new(data)
    expect(r.name).to eq(data[:name])
    expect(r.type).to eq(data[:type])
    expect(r.rating).to eq(data[:rating])
    expect(r.location).to eq(data[:location])
  end

  it "can set distance to route" do
    data = {
      name: "Dopey Duck",
      type: "Trad",
      rating: "5.9",
      location: [
        "North Carolina",
        "2. Northern Mountains Region",
        "Linville Gorge",
        "Shortoff Mountain"
      ],
    }
    r = Route.new(data)
    expect(r.distance_to_route).to eq(nil)
    r.set_distance_to_route(5)
    expect(r.distance_to_route).to eq(5)
  end
end
