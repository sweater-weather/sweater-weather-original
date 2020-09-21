require 'rails_helper'

RSpec.describe CurrentForecast do
  it "can make a CurrentForecast" do
    data = {:icon=>"04d",
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

    cf = CurrentForecast.new(data)
    expect(cf.description).to eq(data[:description])
    expect(cf.current_weather).to eq(data[:current_weather])
    expect(cf.high).to eq(data[:high])
    expect(cf.low).to eq(data[:low])
    expect(cf.date_time).to eq(data[:date_time])
    expect(cf.feels_like).to eq(data[:feels_like])
    expect(cf.humidity).to eq(data[:humidity])
    expect(cf.visibility).to eq(data[:visibility])
    expect(cf.uv_index).to eq(data[:uv_index])
    expect(cf.sunrise).to eq(data[:sunrise])
    expect(cf.sunset).to eq(data[:sunset])
    expect(cf.icon).to eq("http://openweathermap.org/img/wn/#{data[:icon]}@2x.png")
    expect(cf.date_time_formatted).to eq(Time.at(data[:date_time]).strftime('%l:%M %p, %B %d'))
    expect(cf.sunrise_time).to eq(Time.at(data[:sunrise]).strftime('%l:%M %p'))
    expect(cf.sunset_time).to eq(Time.at(data[:sunset]).strftime('%l:%M %p'))
  end
end
