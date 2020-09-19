class DailyForecast
  attr_reader :date_time,
              :icon,
              :description,
              :snow_percipitation,
              :rain_percipitation,
              :high,
              :low

  def initialize(weekly_forecast_params)
    @description = weekly_forecast_params[:description]
    @icon = icon_link(weekly_forecast_params[:icon])
    @date_time = weekly_forecast_params[:date_time]
    @weekday = date_time_formatted
    @high = weekly_forecast_params[:high]
    @low = weekly_forecast_params[:low]
    @snow_percipitation = weekly_forecast_params[:snow_percipitation]
    @rain_percipitation = weekly_forecast_params[:rain_percipitation]
  end

  def date_time_formatted
    Time.at(@date_time).strftime('%A')
  end

  def icon_link(code)
    "http://openweathermap.org/img/wn/#{code}@2x.png"
  end
end
