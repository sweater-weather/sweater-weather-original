require 'rails_helper'

RSpec.describe 'Climging Routes Facade' do
  it "can compile info to make a ClimbingRoute" do
    r_data = {
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
    r = Route.new(r_data)
    data = {
      location: "erwin,tn",
      forecast: {
        "summary": "Raining cats and dogs",
        "temperature": "65"
      },
      routes: [r]
    }
    cr = ClimbingRoute.new(data)
    expect(cr.location).to eq(data[:location])
    expect(cr.forecast).to eq(data[:forecast])
    expect(cr.routes).to eq(data[:routes])
  end
end
