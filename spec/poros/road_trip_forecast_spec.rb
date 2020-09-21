require 'rails_helper'

RSpec.describe RoadTripForecast do
  it "can create a RoadTripForecast" do
    params = {
      temperature: 87,
      description: 'clear sky'
    }
    rtf = RoadTripForecast.new(params)

    expect(rtf.temperature).to eq(params[:temperature])
    expect(rtf.description).to eq(params[:description])
  end
end
