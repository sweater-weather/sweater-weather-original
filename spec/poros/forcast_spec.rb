require 'rails_helper'

RSpec.describe Forecast do
  it "can create a forecast" do
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
    expect(f.location).to eq(l)
    expect(f.current_forecast).to eq(cf)
    expect(f.hourly_forecast).to eq(hf)
    expect(f.weekly_forecast).to eq(df)
  end
end
