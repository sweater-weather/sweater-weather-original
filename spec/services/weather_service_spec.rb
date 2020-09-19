require 'rails_helper'

RSpec.describe 'Weather Service' do
  it "can get forcast" do
    keys1 = [:lat, :lon, :timezone, :timezone_offset, :current]
    keys2 = [:dt, :sunrise, :sunset, :temp, :feels_like, :pressure, :humidity, :dew_point, :uvi, :clouds, :visibility, :wind_speed, :wind_deg, :weather]
    keys3 = [:dt, :temp, :feels_like, :pressure, :humidity, :dew_point, :clouds, :visibility, :wind_speed, :wind_deg, :weather, :pop]
    keys4 = [:dt, :sunrise, :sunset, :temp, :feels_like, :pressure, :humidity, :dew_point, :wind_speed, :wind_deg, :weather, :uvi]

    weather = WeatherService.new.get_forecast(38.892062, -77.019912)
    keys2.each do |key|
      expect(weather[:current]).to have_key(key)
    end
    expect(weather).to_not have_key(:minutely)
    keys3.each do |key|
      expect(weather[:hourly][0]).to have_key(key)
    end
    keys4.each do |key|
      expect(weather[:daily][0]).to have_key(key)
    end
  end
end
