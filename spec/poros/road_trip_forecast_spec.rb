require 'rails_helper'

RSpec.describe RoadTripForecast do
  it "can create a RoadTripForecast" do
    params = {:dt=>1600786800,
      :temp=>70.83,
      :feels_like=>72.18,
      :pressure=>1015,
      :humidity=>72,
      :dew_point=>61.52,
      :clouds=>0,
      :visibility=>10000,
      :wind_speed=>4.32,
      :wind_deg=>312,
      :weather=>[{
        :id=>800,
        :main=>"Clear",
        :description=>"clear sky",
        :icon=>"01d"}],
      :pop=>0
    }
    rtf = RoadTripForecast.new(params)
    expect(rtf.temperature).to eq(params[:temp])
    expect(rtf.description).to eq(params[:weather][0][:description])
  end
end
