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
      distance_to_route: "76.876"
    }
    r = Route.new(data)
    expect(r.name).to eq(data[:name])
    expect(r.type).to eq(data[:type])
    expect(r.rating).to eq(data[:rating])
    expect(r.location).to eq(data[:location])
    expect(r.distance_to_route).to eq(data[:distance_to_route])
  end
end
