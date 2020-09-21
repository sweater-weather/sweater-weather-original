class DailyForecast
  include Formattable

  attr_reader :date_time,
              :weekday,
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
    @weekday = format_time(@date_time, '%A')
    @high = weekly_forecast_params[:high]
    @low = weekly_forecast_params[:low]
    @snow_percipitation = weekly_forecast_params[:snow_percipitation]
    @rain_percipitation = weekly_forecast_params[:rain_percipitation]
  end
end
