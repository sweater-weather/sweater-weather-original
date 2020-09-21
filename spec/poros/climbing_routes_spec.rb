require 'rails_helper'

RSpec.describe ClimbingRoute do
  it "can create a ClimbingRoute" do
    data = {
      "name": "Dopey Duck",
      "type": "Trad",
      "rating": "5.9",
      "location": [
        "North Carolina",
        "2. Northern Mountains Region",
        "Linville Gorge",
        "Shortoff Mountain"
      ],
      "distance_to_route": "76.876"
    }
    cr = ClimbingRoute.new(data)
    expect(cr.name).to eq(data['name'])
    expect(cr.type).to eq(data['type'])
    expect(cr.rating).to eq(data['rating'])
    expect(cr.location).to eq(data['location'])
    expect(cr.distance_to_route).to eq(data['distance_to_route'])
  end
end
