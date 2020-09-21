require 'rails_helper'

RSpec.describe HourlyForecast do
  it "can create an HourlyForecast" do
    data = {
      :icon=>"04d",
      :temperature=>83.46,
      :date_time=>1600538400
    }
    hf = HourlyForecast.new(data)
    expect(hf.icon).to eq("http://openweathermap.org/img/wn/#{data[:icon]}@2x.png")
    expect(hf.temperature).to eq(data[:temperature])
    expect(hf.date_time).to eq(data[:date_time])
    expect(hf.date_time_formatted).to eq(Time.at(data[:date_time]).strftime('%l %p'))
  end
end
