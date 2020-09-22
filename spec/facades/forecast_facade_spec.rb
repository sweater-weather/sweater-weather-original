require 'rails_helper'

RSpec.describe ForecastFacade do
  it "can make Forecast", :vcr do
    VCR.use_cassette('/ForecastFacade/can_make_Forecast') do
      forecast = ForecastFacade.new('denver,co').weather
      expect(forecast).to be_an_instance_of(Forecast)
    end
  end
end
