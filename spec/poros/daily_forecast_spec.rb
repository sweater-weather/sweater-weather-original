require 'rails_helper'

RSpec.describe DailyForecast do
  it "can create a DailyForecast" do
  data = {
    :date_time=>1600624800,
    :icon=>"03d",
    :description=>"Clouds",
    :snow_percipitation=>nil,
    :rain_percipitation=>nil,
    :high=>66.69,
    :low=>86.23
  }
  df = DailyForecast.new(data)
    expect(df.date_time).to eq(data[:date_time])
    expect(df.description).to eq(data[:description])
    expect(df.snow_percipitation).to eq(data[:snow_percipitation])
    expect(df.rain_percipitation).to eq(data[:rain_percipitation])
    expect(df.high).to eq(data[:high])
    expect(df.low).to eq(data[:low])
    expect(df.icon).to eq("http://openweathermap.org/img/wn/#{data[:icon]}@2x.png")
    expect(df.weekday).to eq(Time.at(data[:date_time]).strftime("%A"))
  end
end
