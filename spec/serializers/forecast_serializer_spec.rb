require 'rails_helper'

RSpec.describe ForecastSerializer do
  it "can serialize a forecast" do
    cf_data = {:icon=>"04d",
     :description=>"Clouds",
     :current_weather=>81.01,
     :high=>85.86,
     :low=>70.03,
     :date_time=>1600535884,
     :feels_like=>69.21,
     :humidity=>15,
     :visibility=>10000,
     :uv_index=>7.04,
     :sunrise=>1600519516,
     :sunset=>1600563710
   }
    df_data = {:icon=>"04d",
      :description=>"Clouds",
      :current_weather=>81.01,
      :high=>85.86,
      :low=>70.03,
      :date_time=>1600535884,
      :feels_like=>69.21,
      :humidity=>15,
      :visibility=>10000,
      :uv_index=>7.04,
      :sunrise=>1600519516,
      :sunset=>1600563710
    }
    hf_data = {
      :icon=>"04d",
      :temperature=>83.46,
      :date_time=>1600538400
    }
    l_data = {:city=>"Denver", :state=>"CO", :country=>"US"}
    l = Location.new(l_data)
    hf = HourlyForecast.new(hf_data)
    df = DailyForecast.new(df_data)
    cf = CurrentForecast.new(cf_data)
    f_data = {
      location: l,
      current_forecast: cf,
      hourly_forecast: hf,
      weekly_forecast: df
    }
    f = Forecast.new(f_data)
    serialized = ForecastSerializer.new(f).serializable_hash

    expect(serialized).to have_key(:data)

    data_keys = [:id, :type, :attributes]
    data_keys.each do |key|
      expect(serialized[:data]).to have_key(key)
    end

    attributes_keys = [:location, :current_forecast, :weekly_forecast, :hourly_forecast]
    attributes_keys.each do |key|
      expect(serialized[:data][:attributes]).to have_key(key)
    end
  end
end
