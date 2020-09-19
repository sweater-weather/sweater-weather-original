class HourlyForecast
  attr_reader :icon,
              :date_time,
              :temperature,
              :date_time_formatted

  def initialize(hourly_forecast_params)
    @temperature = hourly_forecast_params[:temperature]
    @date_time = hourly_forecast_params[:date_time]
    @date_time_formatted = time
    @icon = icon_link(hourly_forecast_params[:icon])
  end

  def icon_link(code)
    "http://openweathermap.org/img/wn/#{code}@2x.png"
  end

  def time
    Time.at(@date_time).strftime('%l %p')
  end
end
